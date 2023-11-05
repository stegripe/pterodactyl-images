# TAGS: iron, lts
# VARIANT:
# PLATFORMS: linux/amd64
FROM node:20.9.0-bullseye-slim

ARG BUILDPLATFORM

RUN apt-get update \
    && apt-get install -y --no-install-recommends iputils-ping procps tini tzdata curl ffmpeg git openssl sqlite3 tar build-essential python3 dnsutils iproute2 ca-certificates wget gnupg libtool \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c "echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google.list" \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && npm i npm@latest -g \
    && corepack enable && corepack prepare yarn@stable pnpm@latest \
    && groupadd -r container && useradd -d /home/container -r -g container -G audio,video container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
