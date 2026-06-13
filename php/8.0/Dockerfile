# TAGS: 8.0
# VARIANT: apache
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM serversideup/docker-php:8.0-apache

LABEL maintainer="Stegripe <support@stegripe.com>"

# Fix AH00558 warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Create Pterodactyl container user
USER root
RUN groupadd -r container && useradd -d /home/container -m -r -g container container
USER container

ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
