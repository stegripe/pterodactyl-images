# TAGS: 8.2
# VARIANT: fpm-nginx-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM serversideup/php:8.2-fpm-nginx-alpine

LABEL maintainer="Stegripe <support@stegripe.com>"

ENV APP_BASE_DIR=/home/container
ENV HOME=/home/container

WORKDIR /home/container

USER root

RUN mkdir -p /tmp/default_configs/nginx/conf.d /tmp/default_configs/php /tmp/default_configs/public \
    && echo -e "user www-data;\nworker_processes auto;\npid /run/nginx.pid;\nevents { worker_connections 1024; }\nhttp { include /etc/nginx/mime.types; default_type application/octet-stream; sendfile on; keepalive_timeout 65; include /home/container/nginx/conf.d/*.conf; }" > /tmp/default_configs/nginx/nginx.conf \
    && echo -e "server { listen 8080; listen [::]:8080; server_name _; root /home/container/public; index index.php index.html; location / { try_files \$uri \$uri/ /index.php?\$query_string; } location ~ \\\\.php\$ { fastcgi_pass 127.0.0.1:9000; fastcgi_index index.php; include fastcgi_params; fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name; } }" > /tmp/default_configs/nginx/conf.d/default.conf \
    && echo -e "[global]\npid = /run/php-fpm.pid\nerror_log = /dev/stderr\n[www]\nuser = www-data\ngroup = www-data\nlisten = 127.0.0.1:9000\npm = ondemand\npm.max_children = 20" > /tmp/default_configs/php/php-fpm.conf \
    && echo -e "memory_limit = 512M\nupload_max_filesize = 100M\npost_max_size = 100M" > /tmp/default_configs/php/php.ini \
    && echo -e "<?php phpinfo();" > /tmp/default_configs/public/index.php

RUN mkdir -p /etc/entrypoint.d && echo '#!/bin/ash\n\
if [ ! -d "/home/container/nginx" ]; then\n\
    cp -r /tmp/default_configs/* /home/container/\n\
fi\n\
PORT="${SERVER_PORT:-8080}"\n\
if [ "$PORT" != "8080" ] && [ -f "/home/container/nginx/conf.d/default.conf" ]; then\n\
    sed -i "s/listen 8080/listen ${PORT}/g" /home/container/nginx/conf.d/default.conf\n\
    sed -i "s/listen \[::\]:8080/listen \[::\]:${PORT}/g" /home/container/nginx/conf.d/default.conf\n\
fi' > /etc/entrypoint.d/00-init-configs.sh && chmod +x /etc/entrypoint.d/00-init-configs.sh

COPY ../entrypoint.sh /entrypoint.sh
