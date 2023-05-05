# TAGS: focal
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM --platform=$BUILDPLATFORM ubuntu:20.04

RUN apt update \
    && groupadd -g 997 container \
    && useradd -u 997 -g container container \
    && chmod container /var/lib/dpkg/lock-frontend \
    && chmod container /var/lib/dpkg/lock \
    && chmod container /var/cache/apt/archives/lock \
    && chmod container /var/lib/apt/lists/lock

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
