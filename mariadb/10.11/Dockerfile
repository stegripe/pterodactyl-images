# TAGS: latest
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/ppc64le, linux/s390x
FROM --platform=$BUILDPLATFORM mariadb:10.11.5

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y \
    && apt install -y netcat \
    && groupadd -r container && useradd -d /home/container -r -g container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
