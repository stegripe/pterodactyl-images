# TAGS: 8.2
# VARIANT: fpm-nginx
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM alpine:3.22

RUN apk add --no-cache \
    nginx \
    php82 \
    php82-ctype \
    php82-curl \
    php82-fileinfo \
    php82-fpm \
    php82-ftp \
    php82-gd \
    php82-gettext \
    php82-mbstring \
    php82-opcache \
    php82-openssl \
    php82-pcntl \
    php82-pdo \
    php82-pdo_dblib \
    php82-pdo_mysql \
    php82-pdo_odbc \
    php82-pdo_sqlite \
    php82-pdo_pgsql \
    php82-phar \
    php82-session \
    php82-tokenizer \
    php82-xml \
    php82-xmlreader \
    php82-xmlwriter

RUN ln -sf /usr/bin/php8* /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm8* /usr/sbin/php-fpm

RUN addgroup -S container && adduser -D -h /home/container -S -G container container

ENV USER=container
ENV HOME=/home/container

USER container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/sh", "/entrypoint.sh"]
