#!/bin/bash

# ==========================================
# ERROR STATISTICS ANALYZER
# ------------------------------------------
# Extracts and summarises error messages
# from a log file.
#
# Displays frequency of each error type,
# useful for identifying recurring issues.
# ==========================================

LOGFILE=$1

# Temporary file for storing error lines
tmp_errors=$(mktemp)

# Ensure cleanup on exit
trap 'rm -f "$tmp_errors"' EXIT

# Extract error lines
grep "ERROR" "$LOGFILE" > "$tmp_errors"

# Count unique error messages
sort "$tmp_errors" | uniq -c