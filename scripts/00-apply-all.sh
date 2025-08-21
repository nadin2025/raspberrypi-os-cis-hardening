#!/usr/bin/env bash
set -euo pipefail
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="/var/log/hardening"
mkdir -p "$LOG_DIR"
chmod 750 "$LOG_DIR"

order=(
  "01-system-update.sh"
  "02-users-auth.sh"
  "03-ssh-hardening.sh"
  "04-services-hardening.sh"
  "05-firewall-ufw.sh"
  "06-fail2ban.sh"
  "07-aide.sh"
  "08-auto-updates.sh"
  "09-logging-audit.sh"
  "10-kernel-params.sh"
  "11-permissions-core.sh"
  "12-banners.sh"
)

for s in "${order[@]}"; do
  echo "[*] Running $s"
  bash "$SCRIPTS_DIR/$s" | tee -a "$LOG_DIR/${s}.log"
done

echo "[✓] Hardening completed. Review logs in $LOG_DIR"
