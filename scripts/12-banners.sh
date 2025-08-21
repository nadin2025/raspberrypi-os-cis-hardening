#!/usr/bin/env bash
set -euo pipefail

# Legal banners (non-privacy violating; generic warning)
MOTD="/etc/motd"
ISSUE="/etc/issue"
ISSUEN="/etc/issue.net"

cat > "$ISSUE" <<'EOF'
Authorized access only. Use of this system is restricted to authorized users.
All activities may be monitored and reported.
EOF

cp "$ISSUE" "$ISSUEN"
# Do not expose OS details in issue/motd
: > "$MOTD"

echo "[✓] Login banners set (issue/issue.net), motd cleared"
