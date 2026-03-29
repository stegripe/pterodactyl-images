# TAGS:
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM --platform=$BUILDPLATFORM alpine:3.22 AS build
ARG VERSION=1.25.1

RUN apk add --no-cache autoconf automake curl gcc libc-dev libevent-dev libtool make openssl-dev pkgconfig

RUN curl -sS -o /pgbouncer.tar.gz -L https://pgbouncer.github.io/downloads/files/$VERSION/pgbouncer-$VERSION.tar.gz && \
    tar -xzf /pgbouncer.tar.gz && mv /pgbouncer-$VERSION /pgbouncer

    RUN cd /pgbouncer && ./configure --prefix=/usr && make -j$(nproc) pgbouncer && strip pgbouncer

FROM --platform=$BUILDPLATFORM alpine:3.22

RUN apk add --no-cache libevent postgresql-client iproute2 \
    && addgroup -S container && adduser -D -h /home/container -S -G container container

COPY --from=build /pgbouncer/pgbouncer /usr/bin/pgbouncer
COPY --from=build /pgbouncer/etc/pgbouncer.ini /home/container/pgbouncer.ini.example
COPY --from=build /pgbouncer/etc/userlist.txt /home/container/userlist.txt.example

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/sh", "/entrypoint.sh"]
