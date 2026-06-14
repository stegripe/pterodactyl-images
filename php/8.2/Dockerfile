# TAGS: 8.2
# VARIANT: fpm-nginx-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM serversideup/php:8.2-fpm-nginx-alpine

LABEL maintainer="Stegripe <support@stegripe.com>"

ENV APP_BASE_DIR=/home/container
ENV HOME=/home/container

USER root

RUN apk add --no-cache tini \
    && deluser www-data \
    && adduser -D -h /home/container container

COPY ../entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
