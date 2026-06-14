# TAGS: 8.2
# VARIANT: fpm-nginx-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM serversideup/php:8.2-fpm-nginx-alpine

LABEL maintainer="Stegripe <support@stegripe.com>"

ENV APP_BASE_DIR=/home/container
ENV HOME=/home/container

RUN deluser www-data || true && \
    adduser -D -h /home/container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]