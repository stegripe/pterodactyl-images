# TAGS: uv
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM --platform=$BUILDPLATFORM debian:bookworm-slim

COPY --from=ghcr.io/astral-sh/uv:0.8.15 /uv /uvx /usr/local/bin/

RUN apt update \
    && apt install -y git build-essential ca-certificates iputils-ping curl iproute2 ffmpeg procps tini tar tzdata \
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
