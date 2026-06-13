#!/bin/bash
# PHP FPM-Apache Pterodactyl Entrypoint

TZ=${TZ:-UTC}
export TZ

cd /home/container

# Print versions
echo "PHP Version: $(php -v | head -n 1)"
echo "Composer Version: $(composer --version 2>/dev/null || echo 'not available')"

# Configure Apache to use Pterodactyl port
APACHE_PORT="${SERVER_PORT:-8080}"
sed -i "s/Listen 80/Listen ${APACHE_PORT}/g" /etc/apache2/ports.conf
sed -i "s/:80>/:${APACHE_PORT}>/g" /etc/apache2/sites-available/*.conf /etc/apache2/sites-enabled/*.conf 2>/dev/null || true
echo "Apache listening on port ${APACHE_PORT}"

# Parse startup command (replace {{VAR}} with ${VAR})
STARTUP_CMD="${STARTUP_CMD:-apache2-foreground}"
PARSED=$(echo "${STARTUP_CMD}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "Starting: ${PARSED}"

exec env ${PARSED}
