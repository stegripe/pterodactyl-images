# TAGS:
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM --platform=$BUILDPLATFORM mongo:4.4.24

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y \
    && apt install -y netcat iproute2 \
    && groupadd -r container && useradd -d /home/container -r -g container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
