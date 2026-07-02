# TAGS: 8.1
# VARIANT: fpm-nginx
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM alpine:3.24

RUN apk add --no-cache \
    git \
    nginx \
    php81 \
    php81-ctype \
    php81-curl \
    php81-fileinfo \
    php81-fpm \
    php81-ftp \
    php81-gd \
    php81-gettext \
    php81-mbstring \
    php81-opcache \
    php81-openssl \
    php81-pcntl \
    php81-pdo \
    php81-pdo_dblib \
    php81-pdo_mysql \
    php81-pdo_odbc \
    php81-pdo_sqlite \
    php81-pdo_pgsql \
    php81-phar \
    php81-session \
    php81-tokenizer \
    php81-xml \
    php81-xmlreader \
    php81-xmlwriter

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
