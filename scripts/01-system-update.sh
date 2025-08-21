#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean -y

# Lock predictable-path symlinks (minor hygiene)
chmod o-rwx /root || true

echo "[✓] System updated"
