#!/usr/bin/env bash
set -euo pipefail

# Ensure sudo requires password, disable sudo via NOPASSWD if present
if grep -qE 'NOPASSWD' /etc/sudoers /etc/sudoers.d/* 2>/dev/null; then
  sed -i 's/NOPASSWD:ALL/PASSWD:ALL/g' /etc/sudoers
  sed -i 's/NOPASSWD:ALL/PASSWD:ALL/g' /etc/sudoers.d/* || true
fi

# Lock root login if not already
passwd -l root || true

# Password policy (PAM + login.defs)
apt-get install -y libpam-pwquality

# Enforce pwquality (CIS-aligned, conservative)
PWQ="/etc/security/pwquality.conf"
sed -i 's/^#\?minlen.*/minlen = 12/' "$PWQ"
sed -i 's/^#\?dcredit.*/dcredit = -1/' "$PWQ"
sed -i 's/^#\?ucredit.*/ucredit = -1/' "$PWQ"
sed -i 's/^#\?lcredit.*/lcredit = -1/' "$PWQ"
sed -i 's/^#\?ocredit.*/ocredit = -1/' "$PWQ"

# Login.defs: aging
LOGIN="/etc/login.defs"
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS\t90/' "$LOGIN"
sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS\t1/' "$LOGIN"
sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE\t7/' "$LOGIN"

# Ensure new shells have umask 027
for f in /etc/profile /etc/bash.bashrc; do
  if ! grep -q 'umask 027' "$f"; then echo 'umask 027' >> "$f"; fi
done

echo "[✓] Users & auth policy set (root locked, password policy, umask)"
