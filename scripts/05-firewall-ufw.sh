#!/usr/bin/env bash
set -euo pipefail

apt-get install -y ufw

ufw default deny incoming
ufw default allow outgoing

# Allow SSH explicitly (change port if you modify sshd_config Port)
ufw allow 22/tcp

# Enable silently (non-interactive)
yes | ufw enable

systemctl enable ufw
echo "[✓] UFW configured (deny-in, allow-out, SSH allowed)"
