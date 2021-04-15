FROM ubuntu:bionic-20210325 AS base

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

ENV RUSTUP_VERSION=1.23.1
ENV RUST_VERSION=nightly-2019-12-05
ENV RUST_ARCH=x86_64-unknown-linux-gnu

ENV RUSTUP_HOME /usr/local/rustup
ENV CARGO_HOME /usr/local/cargo
ENV PATH $CARGO_HOME/bin:$PATH

RUN apt-get update \
    && apt-get install --yes \
    build-essential \
    llvm-6.0 \
    clang-6.0 \
    libclang-6.0-dev \
    cmake \
    libssl-dev \
    pkg-config \
    python3 \
    unzip \
    wget

ADD https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init rustup-init

RUN chmod +x rustup-init \
    && ./rustup-init -y --no-modify-path --profile minimal --default-toolchain none \
    && rm rustup-init \
    && rustup install $RUST_VERSION \
    && rustup +$RUST_VERSION component add rustfmt rustc-dev \
    && rustup +$RUST_VERSION target add wasm32-unknown-unknown \
    # We need to install with `--locked` because of https://github.com/immunant/c2rust/issues/323
    && cargo +$RUST_VERSION install c2rust --locked

ENTRYPOINT ["c2rust"]
