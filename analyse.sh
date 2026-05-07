#!/bin/bash

# ==========================================
# GENERAL LOG ANALYSIS SCRIPT
# ------------------------------------------
# This script analyses a log file and extracts:
# - number of failed login attempts
# - number of error messages
# - most common IP address
# ==========================================

LOGFILE=$1

# Create temporary file for storing extracted IPs
tmp_ips=$(mktemp)

# Ensure temp file is deleted when script exits (even on error)
trap "rm -f $tmp_ips" EXIT

# Count failed login attempts
failed=$(grep "Failed password" "$LOGFILE" | wc -l)

# Extract all IP addresses and store in temp file
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOGFILE" > "$tmp_ips"

# Find most frequent IP
top_ip=$(sort "$tmp_ips" | uniq -c | sort -nr | head -n 1)

# Count error messages
errors=$(grep "ERROR" "$LOGFILE" | wc -l)

# Output results
echo ""
echo "Failed logins: $failed"
echo "Errors: $errors"
echo "Most common IP: $top_ip"