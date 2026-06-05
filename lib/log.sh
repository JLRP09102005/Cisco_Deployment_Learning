#!/bin/bash

#==== ANSI CODES ====
BLUE="\033[1;34m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[1;33m"

#==== FUNCTIONS ====

log_info()
{
    [ -z "$1" ] && return

    local date="$(date '+%d-%m-%y_%H:%M:%S')"
    printf "%b%s:%s\n" "$BLUE" "$date" "$1" > "$LOG_FILE"
}

log_ok()
{
    [ -z "$1" ] && return

    local date="$(date '+%d-%m-%y_%H:%M:%S')"
    printf "%b%s:%s\n" "$GREEN" "$date" "$1" > "$LOG_FILE"
}

log_warn()
{
    [ -z "$1" ] && return

    local date="$(date '+%d-%m-%y_%H:%M:%S')"
    printf "%b%s:%s\n" "$YELLOW" "$date" "$1" > "$LOG_FILE"
}

log_error()
{
    [ -z "$1" ] && return

    local date="$(date '+%d-%m-%y_%H:%M:%S')"
    printf "%b%s:%s\n" "$RED" "$date" "$1" > "$LOG_FILE"
}