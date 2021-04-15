# A Docker image for C2Rust - Transpile C code into Rust

This is a third-party Docker image for the [C2Rust](https://c2rust.com/) transpiler.

This Docker setup is a little more self-contained than [the official C2Rust Docker image](https://c2rust.com/manual/docker/index.html).

Read the [C2Rust Manual](https://c2rust.com/manual/) for instructions on how to use C2Rusgt (and this container) to transpile C source code into Rust source code.


### Using this image with Docker Compose

A typical `docker-compose.yml` file for using this image might look like:

```yaml
version: "3.9"

services:
  c2rust:
    image: neocrym/c2rust
    init: true
    network_mode: host
    working_dir: /host
    volumes:
      - type: bind
        source: "."
        target: /host
```
