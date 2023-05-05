# TAGS: focal
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM --platform=$BUILDPLATFORM ubuntu:20.04

RUN apt update \
    && groupadd -g 997 container \
    && useradd -u 997 -g container container \
    && apt install -y libgtk-3-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
