#!/bin/bash

# ==========================================
# SUSPICIOUS ACTIVITY DETECTOR
# ------------------------------------------
# Identifies IPs responsible for repeated
# failed login attempts.
#
# High frequency may indicate brute-force attacks.
# ==========================================

LOGFILE=$1

# Temporary file for failed IPs
tmp_failed=$(mktemp)

# Clean up temp file on exit
trap "rm -f $tmp_failed" EXIT

# Extract IPs from failed login attempts
grep "Failed password" "$LOGFILE" \
| grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' > "$tmp_failed"

# Display top 5 most frequent offenders (5 = n, can change if wanted)
sort "$tmp_failed" | uniq -c | sort -nr | head -n 5