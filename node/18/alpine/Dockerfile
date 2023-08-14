# TAGS: hydrogen, lts
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/ppc64le, linux/s390x
FROM node:18.17.1-alpine

ARG BUILDPLATFORM

RUN apk add --no-cache tini ca-certificates curl ffmpeg git openssl sqlite tar tzdata build-base python3 \
    && ln -s /usr/bin/python3 /usr/local/bin/python \
    && npm i npm@latest -g \
    && corepack enable && corepack prepare yarn@stable pnpm@latest \
    && addgroup -S container && adduser -D -h /home/container -S -G container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]
