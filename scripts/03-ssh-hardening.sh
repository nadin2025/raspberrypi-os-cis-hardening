#!/usr/bin/env bash
set -euo pipefail

apt-get install -y openssh-server

SSHD_CFG="/etc/ssh/sshd_config"
cp -a "$SSHD_CFG" "${SSHD_CFG}.bak.$(date +%s)"

apply_sshd() {
  local key="$1" val="$2"
  if grep -qE "^\s*${key}\b" "$SSHD_CFG"; then
    sed -i "s|^\s*${key}.*|${key} ${val}|" "$SSHD_CFG"
  else
    echo "${key} ${val}" >> "$SSHD_CFG"
  fi
}

apply_sshd "Protocol" "2"
apply_sshd "PermitRootLogin" "no"
apply_sshd "PasswordAuthentication" "no"
apply_sshd "KbdInteractiveAuthentication" "no"
apply_sshd "ChallengeResponseAuthentication" "no"
apply_sshd "UsePAM" "yes"
apply_sshd "X11Forwarding" "no"
apply_sshd "AllowTcpForwarding" "no"
apply_sshd "PermitEmptyPasswords" "no"
apply_sshd "ClientAliveInterval" "300"
apply_sshd "ClientAliveCountMax" "2"
apply_sshd "LoginGraceTime" "20"
apply_sshd "MaxAuthTries" "3"
apply_sshd "MaxSessions" "3"
apply_sshd "Ciphers" "chacha20-poly1305@openssh.com,aes256-gcm@openssh.com"
apply_sshd "MACs" "hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com"
apply_sshd "KexAlgorithms" "curve25519-sha256,curve25519-sha256@libssh.org"
apply_sshd "UseDNS" "no"

# Optional: Restrict to a specific user/group (edit as needed)
# echo "AllowUsers pi" >> "$SSHD_CFG"

systemctl enable ssh
systemctl restart ssh

echo "[✓] SSH hardened (no root/password login, strong ciphers)"
