# Log Analysis Toolkit

## Overview

A lightweight command-line toolkit for analyzing system logs and identifying patterns such as:

- failed login activity
- error events
- IP frequency
- suspicious behaviour patterns

The toolkit focuses on **clarity, modularity, and practical log analysis workflows**.  
It is designed to work with SSH-style logs (e.g. the provided `sample.log`).

## Features

### Individual Scripts

- **analyse.sh**  
  General analysis:
  - failed login count
  - error count
  - most common IP

- **clean.sh**  
  Filters logs to only relevant entries (errors, login activity)

- **correlate.sh**  
  Finds IPs that appear in both failed and successful logins

- **ip_stats.sh**  
  Displays most frequent IP addresses

- **error_stats.sh**  
  Summarises error messages

- **report.sh**  
  Provides a high-level summary of log behaviour

- **suspicious.sh**  
  Detects repeated failed login attempts (possible brute-force attacks)

- **timeline.sh**  
  Shows distribution of activity over time

## Command Line Interface (tool.sh)

A unified CLI interface is provided via `tool.sh`.

Options directly correspond to the script names.

```bash
chmod +x *.sh
./tool.sh [options] <logfile>
```
