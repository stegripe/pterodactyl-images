# TAGS: 8.2
# VARIANT: fpm-nginx-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM serversideup/php:8.2-fpm-nginx-alpine

LABEL maintainer="Stegripe <support@stegripe.com>"

ENV APP_BASE_DIR=/home/container
ENV HOME=/home/container

WORKDIR /home/container

USER root

# Install dependencies
RUN apk add --no-cache \
    tini \
    ca-certificates \
    curl \
    ffmpeg \
    git \
    openssl \
    sqlite \
    tar \
    tzdata \
    build-base \
    python3 \
    bash \
    && ln -s /usr/bin/python3 /usr/local/bin/python

# Replace default user
RUN deluser www-data || true && \
    addgroup -g 988 container && \
    adduser -D -u 988 -h /home/container -S -G container container

# Create directory structure
RUN mkdir -p \
    /home/container/bin \
    /home/container/nginx/conf.d \
    /home/container/php \
    /home/container/public \
    /home/container/run \
    /home/container/logs \
    /home/container/tmp/nginx

# Copy required binaries only (isolated from base init)
RUN cp $(which nginx) /home/container/bin/nginx && \
    cp $(which php-fpm82 || which php-fpm) /home/container/bin/php-fpm82

# Fix permissions
RUN chown -R container:container /home/container

# Copy entrypoint
COPY ../entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to container user
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# IMPORTANT: Override init bawaan
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]