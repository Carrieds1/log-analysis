#!/bin/bash

# ==========================================
# IP FREQUENCY ANALYZER
# ------------------------------------------
# Extracts all IP addresses from a log file
# and displays them ranked by frequency.
#
# Useful for identifying dominant traffic sources.
# ==========================================

LOGFILE=$1

tmp_ips=$(mktemp)
trap "rm -f $tmp_ips" EXIT

# Extract IP addresses
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOGFILE" > "$tmp_ips"

# Rank by frequency
sort "$tmp_ips" | uniq -c | sort -nr