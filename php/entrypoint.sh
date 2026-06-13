#!/bin/bash
# PHP Apache Pterodactyl Entrypoint
# Default TZ
TZ=${TZ:-UTC}
export TZ

# Calculate internal IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Change to working directory
cd /home/container

# Print PHP and Composer versions
echo "PHP Version: $(php -v | head -n 1)"
echo "Composer Version: $(composer --version 2>/dev/null || echo 'not available')"

# Set Apache port
APACHE_PORT="${APACHE_PORT:-${SERVER_PORT:-8080}}"
export APACHE_PORT

# Set Apache document root
APACHE_DOCUMENT_ROOT="${APACHE_DOCUMENT_ROOT:-/home/container/public}"
export APACHE_DOCUMENT_ROOT

# Ensure Apache log directory exists
mkdir -p /home/container/.apache/logs

# Replace variables in startup command
STARTUP_CMD="${STARTUP_CMD:-apache2-foreground}"
if [ -f /etc/container/environment ]; then
    source /etc/container/environment
fi

# Parse startup command
PARSED=$(echo "${STARTUP_CMD}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "Starting: ${PARSED}"

# Run startup command
exec env ${PARSED}
