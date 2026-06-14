# TAGS: 8.4
# VARIANT: fpm-nginx
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM alpine:latest

RUN apk add --no-cache \
    git \
    nginx \
    php84 \
    php84-ctype \
    php84-curl \
    php84-fileinfo \
    php84-fpm \
    php84-ftp \
    php84-gd \
    php84-gettext \
    php84-mbstring \
    php84-opcache \
    php84-openssl \
    php84-pcntl \
    php84-pdo \
    php84-pdo_dblib \
    php84-pdo_mysql \
    php84-pdo_odbc \
    php84-pdo_sqlite \
    php84-pdo_pgsql \
    php84-phar \
    php84-session \
    php84-tokenizer \
    php84-xml \
    php84-xmlreader \
    php84-xmlwriter

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
