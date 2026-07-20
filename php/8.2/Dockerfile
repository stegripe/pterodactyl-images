# TAGS: 8.2
# VARIANT: fpm-nginx
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM alpine:3.22

ARG PHP_VER=php82

ENV EXT_LIST="bcmath bz2 calendar common ctype curl dom exif ffi fileinfo ftp gd gettext gmp iconv intl mbstring mysqli mysqlnd openssl pcntl pdo pdo_mysql pdo_pgsql pdo_sqlite pgsql phar posix session shmop simplexml soap sockets sodium sqlite3 sysvmsg sysvsem sysvshm tokenizer xml xmlreader xmlwriter xsl zip"

RUN PHP_EXT="" && \
    for ext in $EXT_LIST; do PHP_EXT="$PHP_EXT ${PHP_VER}-$ext"; done && \
    apk update && apk add --no-cache git nginx ${PHP_VER} ${PHP_VER}-fpm $PHP_EXT

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
