# TAGS: latest
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM golang:1.21.5-alpine

ARG BUILDPLATFORM

RUN apk add --update --no-cache tini ca-certificates curl ffmpeg git openssl sqlite tar tzdata build-base libdlib-dev libblas-dev libatlas-base-dev liblapack-dev libjpeg62-turbo-dev \
    && addgroup -S container && adduser -D -h /home/container -S -G container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]
