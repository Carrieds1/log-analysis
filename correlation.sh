#!/bin/bash

# ==========================================
# FAILED → SUCCESS CORRELATION
# ------------------------------------------
# Detects IP addresses that appear in BOTH:
# - failed login attempts
# - successful logins
#
# This may indicate an attacker who eventually
# gained access.
# ==========================================

LOGFILE=$1

# Temporary files
tmp_failed=$(mktemp)
tmp_success=$(mktemp)

# Ensure cleanup even if script crashes
trap "rm -f $tmp_failed $tmp_success" EXIT

# Extract IPs from failed logins
grep "Failed password" "$LOGFILE" \
| grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' > "$tmp_failed"

# Extract IPs from successful logins
grep "Accepted password" "$LOGFILE" \
| grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' > "$tmp_success"

echo "IPs appearing in both failed and successful logins:"

# Find overlapping IPs
cat "$tmp_failed" "$tmp_success" | sort | uniq -d