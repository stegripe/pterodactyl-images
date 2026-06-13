# TAGS: 8.3
# VARIANT: fpm-apache
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM serversideup/php:8.3-fpm-apache

LABEL maintainer="Stegripe <support@stegripe.com>"

# Create Pterodactyl container user and fix Apache config for read-only filesystem
USER root
RUN groupadd -r container && useradd -d /home/container -m -r -g container container \
    && cp -rn /etc/apache2/conf-available/* /etc/apache2/conf-enabled/ 2>/dev/null || true

ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
