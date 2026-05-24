# TAGS: uv
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM --platform=$BUILDPLATFORM alpine:3.22

COPY --from=ghcr.io/astral-sh/uv:0.8.15 /uv /uvx /usr/local/bin/

RUN apk add --no-cache tini ca-certificates curl ffmpeg git openssl sqlite tar tzdata build-base bash \
    && addgroup -S container && adduser -D -h /home/container -S -G container container

USER container
ENV USER=container \
    HOME=/home/container \
    UV_PYTHON_INSTALL_DIR=/home/container/.local/share/uv/python \
    UV_CACHE_DIR=/home/container/.cache/uv \
    PATH=/home/container/.local/bin:/home/container/.cargo/bin:$PATH
WORKDIR /home/container

COPY uv/entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
