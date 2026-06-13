# TAGS: 8.1
# VARIANT: apache
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM php:8.1-apache

LABEL maintainer="Stegripe <support@stegripe.com>"

# Apache modules
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && a2enmod rewrite headers expires

# System dependencies + PHP extensions (parallel) + container user
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git curl unzip zip procps tini ca-certificates iproute2 \
        libicu-dev libzip-dev libpng-dev libjpeg62-turbo-dev \
        libfreetype6-dev libonig-dev libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql intl mbstring zip bcmath gd opcache pcntl \
    && groupadd -r container && useradd -d /home/container -m -r -g container container \
    && rm -rf /var/lib/apt/lists/*

# PHP runtime defaults
RUN { \
	echo "upload_max_filesize=128M"; \
	echo "post_max_size=128M"; \
	echo "memory_limit=512M"; \
	echo "max_execution_time=120"; \
	echo "max_input_time=60"; \
	echo "opcache.enable=1"; \
	echo "opcache.enable_cli=1"; \
	echo "opcache.validate_timestamps=1"; \
	echo "opcache.max_accelerated_files=20000"; \
} > /usr/local/etc/php/conf.d/laravel.ini

# Apache non-root config
RUN { \
	echo "Listen \${APACHE_PORT}"; \
	echo "<VirtualHost *:\${APACHE_PORT}>"; \
	echo "    DocumentRoot \${APACHE_DOCUMENT_ROOT}"; \
	echo "    <Directory \${APACHE_DOCUMENT_ROOT}>"; \
	echo "        Options -Indexes +FollowSymLinks"; \
	echo "        AllowOverride All"; \
	echo "        Require all granted"; \
	echo "    </Directory>"; \
	echo "    ErrorLog \${APACHE_LOG_DIR}/error.log"; \
	echo "    CustomLog \${APACHE_LOG_DIR}/access.log combined"; \
	echo "</VirtualHost>"; \
} > /etc/apache2/sites-available/laravel.conf \
    && a2dissite 000-default.conf \
    && a2ensite laravel.conf

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# Container user
USER container
ENV USER=container HOME=/home/container \
    APACHE_RUN_USER=container APACHE_RUN_GROUP=container \
    APACHE_PORT=8080 APACHE_DOCUMENT_ROOT=/home/container \
    APACHE_LOG_DIR=/home/container/.apache/logs \
    COMPOSER_HOME=/home/container/.composer
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
