# TAGS: uv
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM --platform=$BUILDPLATFORM debian:trixie-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends git build-essential ca-certificates iputils-ping curl iproute2 ffmpeg procps tini tar tzdata \
    && groupadd -r container && useradd -d /home/container -m -r -g container container \
    && rm -rf /var/lib/apt/lists/*

USER container
ENV USER=container \
    HOME=/home/container \
    UV_PYTHON_INSTALL_DIR=/home/container/.local/share/uv/python \
    UV_CACHE_DIR=/home/container/.cache/uv \
    PATH=/home/container/.local/bin:/home/container/.cargo/bin:$PATH
WORKDIR /home/container

COPY uv/entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
