#!/bin/bash

# ==========================================
# LOG CLEANER / FILTER
# ------------------------------------------
# Filters a log file to show only relevant
# security-related entries:
# - errors
# - failed logins
# - successful logins
#
# Helps reduce noise and focus analysis.
# ==========================================

LOGFILE=$1

echo "=== FILTERED LOG OUTPUT ==="

# Extract relevant lines only
grep -E "ERROR|Failed|Accepted" "$LOGFILE"