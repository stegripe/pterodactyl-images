# TAGS:
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM --platform=$BUILDPLATFORM python:3.7.16-alpine

RUN apk add --no-cache tini ca-certificates curl ffmpeg git openssl sqlite tar tzdata build-base \
    && addgroup -S container && adduser -D -h /home/container -S -G container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]
