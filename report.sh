#!/bin/bash

# ==========================================
# SUMMARY REPORT GENERATOR
# ------------------------------------------
# Provides a high-level overview of log activity:
# - total failed logins
# - total errors
# - most frequent IP address
# - number of unique IPs
#
# Designed as a quick situational overview tool.
# ==========================================

LOGFILE=$1

# Count failed login attempts
failed=$(grep "Failed password" "$LOGFILE" | wc -l)

# Count error messages
errors=$(grep "ERROR" "$LOGFILE" | wc -l)

# Determine most common IP address
top_ip=$(grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOGFILE" \
| sort | uniq -c | sort -nr | head -n 1)

# Count unique IPs
unique_ips=$(grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOGFILE" \
| sort | uniq | wc -l)

# Output summary
echo "Failed logins: $failed"
echo "Errors: $errors"
echo "Most common IP: $top_ip"
echo "Unique IPs: $unique_ips"