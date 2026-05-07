#!/bin/bash

# ================= # 
# LOG ANALYSIS TOOL #
# ================= #

LOGFILE=""
MODES=()

# -------- COLOURS -------- #
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
RESET='\033[0m'

# -------- HELP -------- #
print_help() {
    echo "Usage:"
    echo "  $0 <logfile>"
    echo "  $0 [--options] <logfile>"
    echo ""
    echo "Options:"
    echo "  --analyse      General analysis"
    echo "  --correlate    Find IPs with failed and successful logins"
    echo "  --clean        Show filtered log output"
    echo "  --ips          Show IP frequency"
    echo "  --errors       Show error stats"
    echo "  --suspicious   Detect brute-force attempts"
    echo "  --timeline     Show login timeline"
    echo "  --report       Summary report"
    echo "  --help         Show this help"
}

# -------- ARG PARSING -------- #
for arg in "$@"; do
    case "$arg" in
        --help)
            print_help
            exit 0
            ;;
        --ips|--errors|--suspicious|--timeline|--report|--analyse|--correlate|--clean)
            MODES+=("$arg")
            ;;

        *)
            if test -z "$LOGFILE"; then
                LOGFILE="$arg"
            else
                echo -e "${RED}Error: Unexpected argument '$arg'${RESET}"
                exit 1
            fi
            ;;

    esac
done

# -------- VALIDATION -------- #
if test -z "$LOGFILE"; then
    echo -e "${RED}Error: No logfile provided${RESET}"
    print_help
    exit 1
fi

if test ! -f "$LOGFILE"; then
    echo -e "${RED}Error: File '$LOGFILE' not found${RESET}"
    exit 1
fi

# Default: run everything
if test ${#MODES[@]} -eq 0; then
    MODES=(--analyse --ips --errors --suspicious --correlate --timeline --report --clean)
fi

# -------- EXECUTION -------- # 
echo -e "${BLUE}==============================${RESET}"
echo -e "${BLUE} LOG ANALYSIS TOOLKIT${RESET}"
echo -e "${BLUE}==============================${RESET}"

for mode in "${MODES[@]}"; do
    case "$mode" in
        --analyse)
            echo -e "\n${GREEN}--- General Analysis ---${RESET}"
            bash analyse.sh "$LOGFILE"
            ;;
        --correlate)
            echo -e "\n${YELLOW}--- Correlation ---${RESET}"
            bash correlation.sh "$LOGFILE"
            ;;
        --clean)
            echo -e "\n${BLUE}--- Filtered Log ---${RESET}"
            bash clean.sh "$LOGFILE"
            ;;
        --errors)
            echo -e "\n${RED}--- Error Statistics ---${RESET}"
            bash error_stats.sh "$LOGFILE"
            ;;
        --ips)
            echo -e "\n${GREEN}--- IP Statistics ---${RESET}"
            bash ip_stats.sh "$LOGFILE"
            ;;
        --report)
            echo -e "\n${GREEN}--- Summary Report ---${RESET}"
            bash report.sh "$LOGFILE"
            ;;
        --suspicious)
            echo -e "\n${YELLOW}--- Suspicious Activity ---${RESET}"
            bash suspicious.sh "$LOGFILE"
            ;;
        --timeline)
            echo -e "\n${BLUE}--- Timeline ---${RESET}"
            bash timeline.sh "$LOGFILE"
            ;;
    esac
done
