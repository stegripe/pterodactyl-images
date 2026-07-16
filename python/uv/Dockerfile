# TAGS: uv
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM debian:trixie-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends procps tini tzdata curl ffmpeg git openssl sqlite3 tar build-essential python3 dnsutils iproute2 ca-certificates \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r container && useradd -d /home/container -r -g container container

ENV USER=container
ENV HOME=/home/container
ENV UV_PYTHON_INSTALL_DIR=/home/container/.local/share/uv/python
ENV UV_CACHE_DIR=/home/container/.cache/uv
ENV PATH=/home/container/.local/bin:/home/container/.cargo/bin:$PATH

USER container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
