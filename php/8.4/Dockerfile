# TAGS: latest
# VARIANT: apache
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM php:8.4-apache

LABEL maintainer="Stegripe <support@stegripe.com>"

# System packages
RUN apt-get update && apt-get install -y \
        curl git unzip zip \
        libicu-dev libzip-dev libpng-dev libjpeg62-turbo-dev \
        libfreetype6-dev libonig-dev libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Apache config
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && a2enmod rewrite headers

# PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql intl mbstring zip bcmath gd opcache pcntl

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

COPY entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
