Notes & Ops

SSH keys: Since password auth is disabled, ensure you have a working SSH key for your user before applying.

Services: 04-services-hardening.sh removes Avahi and disables Bluetooth/CUPS; tweak for your use case.

Auditd: On Pi, audit may add overhead; keep if you need detailed logs. Else, comment installs in 09-logging-audit.sh.

IPv6: The scripts harden but do not disable IPv6. If you need to fully disable it, let me know and I’ll add a safe toggle on next release.
