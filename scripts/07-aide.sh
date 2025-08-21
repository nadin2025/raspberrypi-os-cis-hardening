#!/usr/bin/env bash
set -euo pipefail

apt-get install -y aide

# Initialize database if not present
if [ ! -f /var/lib/aide/aide.db.gz ]; then
  aideinit
  cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
fi

# Add daily cron (systemd timer on Bookworm optional)
CRON="/etc/cron.daily/aide-check"
cat > "$CRON" <<'EOF'
#!/usr/bin/env bash
/usr/bin/aide.wrapper --check || true
EOF
chmod 750 "$CRON"

echo "[✓] AIDE installed and daily check configured"
