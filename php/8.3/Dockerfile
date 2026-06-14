# TAGS: 8.3
# VARIANT: fpm-nginx
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM alpine:latest

RUN apk add --no-cache \
    git \
    nginx \
    php83 \
    php83-ctype \
    php83-curl \
    php83-fileinfo \
    php83-fpm \
    php83-ftp \
    php83-gd \
    php83-gettext \
    php83-mbstring \
    php83-opcache \
    php83-openssl \
    php83-pcntl \
    php83-pdo \
    php83-pdo_dblib \
    php83-pdo_mysql \
    php83-pdo_odbc \
    php83-pdo_sqlite \
    php83-pdo_pgsql \
    php83-phar \
    php83-session \
    php83-tokenizer \
    php83-xml \
    php83-xmlreader \
    php83-xmlwriter

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN ln -sf /usr/bin/php8* /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm8* /usr/sbin/php-fpm

RUN addgroup -S container && adduser -D -h /home/container -S -G container container

ENV USER=container
ENV HOME=/home/container

USER container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/sh", "/entrypoint.sh"]
