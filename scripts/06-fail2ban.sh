#!/usr/bin/env bash
set -euo pipefail

apt-get install -y fail2ban

JAIL="/etc/fail2ban/jail.local"
cat > "$JAIL" <<'EOF'
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 3
backend = systemd
ignoreip = 127.0.0.1/8 ::1

[sshd]
enabled = true
mode = aggressive
port = ssh
logpath = %(sshd_log)s
EOF

systemctl enable fail2ban
systemctl restart fail2ban

echo "[✓] Fail2Ban enabled with aggressive SSH jail"
