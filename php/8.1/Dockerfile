# TAGS: 8.1
# VARIANT: fpm-nginx
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM node:24-bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

ARG PHP_VER=8.1

ENV EXT_LIST="bcmath bz2 curl gd gmp intl mbstring mysqli pdo-mysql pdo-pgsql pdo-sqlite pgsql soap sqlite3 xml xsl zip"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ca-certificates curl dnsutils ffmpeg git \
    iproute2 nginx openssl procps python3 sqlite3 tar tini tzdata \
    && curl -sS https://packages.sury.org/php/README.txt | bash \
    && PHP_PACKAGES="" \
    && for ext in $EXT_LIST; do \
        PHP_PACKAGES="$PHP_PACKAGES php${PHP_VER}-$(echo "$ext")"; \
        done \
    && npm i npm@latest -g \
    && corepack enable \
    && corepack prepare yarn@stable pnpm@latest \
    && apt-get install -y --no-install-recommends php${PHP_VER}-cli php${PHP_VER}-fpm $PHP_PACKAGES \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN ln -sf /usr/bin/php${PHP_VER} /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm${PHP_VER} /usr/sbin/php-fpm

RUN groupadd -r container && useradd -d /home/container -r -g container container

ENV USER=container
ENV HOME=/home/container

USER container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/sh", "/entrypoint.sh"]
