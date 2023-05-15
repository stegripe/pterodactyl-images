# TAGS: gallium
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM node:16.19.1-bullseye-slim

ARG BUILDPLATFORM

RUN apt-get update \
    && apt-get install -y --no-install-recommends iputils-ping procps tini tzdata curl ffmpeg git openssl sqlite3 tar build-essential python3 dnsutils iproute2 ca-certificates \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && npm i npm@latest -g \
    && adduser -D -h /home/container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
