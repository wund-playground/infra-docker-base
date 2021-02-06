#!/usr/bin/env bash

# Enable error handling
set -e

# Enable debugging
# set -x

# Set the current timezone
ln -snf "/usr/share/zoneinfo/${TZ}" "/etc/localtime"
echo "${TZ}" > "/etc/timezone"

# Set the group and user identifiers
groupmod --non-unique --gid ${PGID} docker &> /dev/null
usermod --non-unique --uid ${PUID} docker &> /dev/null

# Add the user to the tty group (fixes permission issues with /dev/std* etc.)
usermod -a -G tty docker &> /dev/null

# Check if we should enable passwordless sudo
if [ "${ENABLE_PASSWORDLESS_SUDO}" = "true" ]; then
  # Add the user to the sudo group
  if ! groups docker | grep -q "\bsudo\b"; then
    usermod -a -G sudo docker &> /dev/null
  fi

  # Allow sudo group uses to run sudo without specifying a password
  sed -i /etc/sudoers -re 's/^%sudo.*/%sudo   ALL=(ALL:ALL) NOPASSWD: ALL/g'

  # Handle Docker socket permissions if necessary
  DOCKER_SOCKET=/var/run/docker.sock
  if [ -S ${DOCKER_SOCKET} ]; then
    DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
    if ! groups docker | grep -q "\b${DOCKER_GID}\b"; then
      usermod -a -G ${DOCKER_GID} docker &> /dev/null
    fi
  fi
fi

# Set the correct permissions
for path in ${CHOWN_DIRS//,/ }
do
  chown -R docker:docker "${path}"
done

# Show a disclaimer
cat << "EOF"

╔════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                            ║
║ 888b     d888          .d8888b.                            888    888                      ║
║ 8888b   d8888         d88P  Y88b                           888    888                      ║
║ 88888b.d88888         888    888                           888    888                      ║
║ 888Y88888P888 888d888 888        888d888 888  888 88888b.  888888 888888 .d88b.  88888b.   ║
║ 888 Y888P 888 888P    888        888P    888  888 888  88b 888    888   d88  88b 888  88b  ║
║ 888  Y8P  888 888     888    888 888     888  888 888  888 888    888   888  888 888  888  ║
║ 888       888 888     Y88b  d88P 888     Y88b 888 888 d88P Y88b.  Y88b. Y88..88P 888  888  ║
║ 888       888 888       Y8888P   888       Y88888 88888P     Y888   Y888  Y88P   888  888  ║
║                                              888 888                                       ║
║                                         Y8b d88P 888                                       ║
║                                           Y88P   888                                       ║
╠═════════════════════════════════════════════════╦══════════════════════════════════════════╣
║ You are using an image that is based on         ║                                          ║
║ a base image that might no longer be maintained ║                                          ║
║                                                 ║                                          ║
║ For more information:                           ║                                          ║
║ github.url goes here                            ║                                          ║
╚═════════════════════════════════════════════════╩══════════════════════════════════════════╝
EOF

# Continue execution
#exec gosu ${PUID}:${PGID} "$@"
exec gosu docker "$@"
