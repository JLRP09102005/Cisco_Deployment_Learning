#!/bin/bash

LOG_FILE="${LOG_FILE:-/dev/null}"

#==== ANSI CODES ====
NC="\033[0m"
BLUE="\033[1;34m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[1;33m"

#==== FUNCTIONS ====
log_init()
{
    mkdir -p logs
    LOG_FILE="logs/deploy_$(date "+%y%m%d_%H%M%S").log"
}

log_info()
{
    [[ -z "$1" ]] && return

    local date="$(date '+%d-%m-%y_%H%M%S')"
    printf "%b%s:%s%b\n" "$BLUE" "$date" "$1" "$NC" | tee -a "$LOG_FILE"
}

log_ok()
{
    [[ -z "$1" ]] && return

    local date="$(date '+%d-%m-%y_%H%M%S')"
    printf "%b%s:%s%b\n" "$GREEN" "$date" "$1" "$NC" | tee -a "$LOG_FILE"
}

log_warn()
{
    [[ -z "$1" ]] && return

    local date="$(date '+%d-%m-%y_%H%M%S')"
    printf "%b%s:%s%b\n" "$YELLOW" "$date" "$1" "$NC" | tee -a "$LOG_FILE"
}

log_error()
{
    [[ -z "$1" ]] && return

    local date="$(date '+%d-%m-%y_%H%M%S')"
    printf "%b%s:%s%b\n" "$RED" "$date" "$1" "$NC" | tee -a "$LOG_FILE"
}