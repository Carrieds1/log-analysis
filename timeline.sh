#!/bin/bash

# ==========================================
# LOGIN TIMELINE ANALYZER
# ------------------------------------------
# Shows frequency of failed login attempts
# over time (by timestamp field).
#
# Helps detect bursts or spikes in activity.
# ==========================================

LOGFILE=$1

tmp_times=$(mktemp)
trap "rm -f $tmp_times" EXIT

# Extract timestamp field (adjust field index if format changes)
grep "Failed password" "$LOGFILE" | cut -d ' ' -f 3 > "$tmp_times"

# Count occurrences by time
sort "$tmp_times" | uniq -c | sort -nr