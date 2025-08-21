#!/usr/bin/env bash
set -euo pipefail

# Disable services not generally needed (adjust to your use)
disable_svc() { systemctl is-enabled "$1" &>/dev/null && systemctl disable --now "$1" || true; }

# Avahi (mDNS) often unnecessary on headless
disable_svc avahi-daemon.service || true
# Bluetooth (if not needed)
disable_svc bluetooth.service || true
# cups (printing)
disable_svc cups.service || true

# Remove unnecessary packages conservatively (comment if needed)
apt-get purge -y avahi-daemon || true
apt-get autoremove -y

systemctl daemon-reload

echo "[✓] Unnecessary services disabled/removed"
