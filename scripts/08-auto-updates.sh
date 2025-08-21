#!/usr/bin/env bash
set -euo pipefail

apt-get install -y unattended-upgrades apt-listchanges

# Enable unattended upgrades
dpkg-reconfigure -f noninteractive unattended-upgrades

# Fine-tune config
UCONF="/etc/apt/apt.conf.d/50unattended-upgrades"
sed -i 's#^\s*//\s*"\${distro_id}:\${distro_codename}-security";#        "${distro_id}:${distro_codename}-security";#' "$UCONF"
# (Optional) enable updates repo auto
if ! grep -q '"${distro_id}:${distro_codename}-updates";' "$UCONF"; then
  sed -i '/Allowed-Origins {/a \        "${distro_id}:${distro_codename}-updates";' "$UCONF"
fi

# Periodic config
PCONF="/etc/apt/apt.conf.d/20auto-upgrades"
cat > "$PCONF" <<'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
EOF

systemctl restart unattended-upgrades
echo "[✓] Unattended upgrades configured"
