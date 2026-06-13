# TAGS: 8.1
# VARIANT: fpm-apache
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM serversideup/docker-php:8.1-fpm-apache

LABEL maintainer="Stegripe <support@stegripe.com>"

# Create Pterodactyl container user
USER root
RUN groupadd -r container && useradd -d /home/container -m -r -g container container
USER container

ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
