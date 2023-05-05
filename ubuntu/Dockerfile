# TAGS: focal
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM --platform=$BUILDPLATFORM ubuntu:20.04

RUN apt update \
    && apt install -y sudo \
    && useradd container \
    && echo "container:container" | chpasswd \
    && adduser -D --gecos '' --ingroup sudo -h /home/container container \
    && sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' \
    && sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' \
    && sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' \
    && echo "container ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && apt update

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

CMD ["/bin/bash"]
