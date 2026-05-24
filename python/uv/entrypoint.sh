#!/bin/bash

set -e

# Default the TZ environment variable to UTC
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

PYTHON_VERSION=${PYTHON_VERSION:-3.13}
case "$PYTHON_VERSION" in
    3.8|3.9|3.10|3.11|3.12|3.13)
        ;;
    *)
        printf "Unsupported PYTHON_VERSION '%s'. Supported versions: 3.8, 3.9, 3.10, 3.11, 3.12, 3.13\n" "$PYTHON_VERSION" >&2
        exit 1
        ;;
esac
export PYTHON_VERSION

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0muv python install %s\n" "$PYTHON_VERSION"
uv python install "$PYTHON_VERSION"

PYTHON_BIN=$(uv python find "$PYTHON_VERSION")
PATH="$(dirname "$PYTHON_BIN"):$PATH"
export PATH

# Print Python version
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mpython --version\n"
python --version

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo -e $(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"

# shellcheck disable=SC2086
eval ${PARSED}
