# TAGS:
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM --platform=$BUILDPLATFORM python:3.10.11-slim-bullseye

RUN apt update \
    && apt install -y git build-essential ca-certificates iputils-ping curl iproute2 ffmpeg procps tini tar tzdata \
    && groupadd -r container && useradd -d /home/container -r -g container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
