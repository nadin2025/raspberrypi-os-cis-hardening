#!/usr/bin/env bash
set -euo pipefail

# rsyslog already present on Pi OS; ensure running
apt-get install -y rsyslog logrotate
systemctl enable --now rsyslog

# auditd (note: on some Pi kernels, audit can be heavier; enable if acceptable)
apt-get install -y auditd audispd-plugins

AUD="/etc/audit/auditd.conf"
sed -i 's/^max_log_file = .*/max_log_file = 20/' "$AUD"
sed -i 's/^max_log_file_action = .*/max_log_file_action = ROTATE/' "$AUD"
sed -i 's/^space_left_action = .*/space_left_action = email/' "$AUD"
sed -i 's/^admin_space_left_action = .*/admin_space_left_action = halt/' "$AUD"

systemctl enable auditd
systemctl restart auditd

echo "[✓] Logging (rsyslog) ensured, auditd configured"
