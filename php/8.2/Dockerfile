# TAGS: 8.2
# VARIANT: fpm-nginx-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM serversideup/php:8.2-fpm-nginx-alpine

LABEL maintainer="Stegripe <support@stegripe.com>"

ENV APP_BASE_DIR=/home/container
ENV HOME=/home/container

WORKDIR /home/container

USER root

RUN deluser www-data && \
    addgroup -g 988 container && \
    adduser -D -u 988 -h /home/container -S -G container container

RUN mkdir -p /home/container/bin /home/container/nginx /home/container/php /home/container/public /run

RUN cp /usr/sbin/nginx /home/container/bin/nginx && \
    cp /usr/sbin/php-fpm82 /home/container/bin/php-fpm82

RUN chmod -R 777 /run /var/lib/nginx /var/log

RUN chown -R container:container /home/container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/sh", "/entrypoint.sh"]
