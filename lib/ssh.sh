#!/bin/bash

SSH_KEY="$HOME/.ssh/nexacore_lab"

ssh_init()
{
    if [[ ! -f "$SSH_KEY" ]]; then

        log_info "SSH key not found, generating new one..."
        ssh-keygen -t ed25519 -f "$SSH_KEY" -C "nexacore-automation" -N ""
        log_ok "New key generated at $SSH_KEY"
        log_warn "Remember to copy the PUBKEY to the pendind config devices before continue"
        log_info "Public key: $(cat "${SSH_KEY}.pub")"
        exit 1

    fi
}

## ssh_exec HOST USER COMMAND
ssh_exec()
{
    [[ -z "$1" ]] && return
    [[ -z "$2" ]] && return
    [[ -z "$3" ]] && return

    local host user cmd
    host="$1"
    user="$2"
    cmd="$3"

    ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no -o ConnectTimeout=5 -o BatchMode=yes "${user}@${host}" "$cmd"
}

## ssh_config HOST USER FILE_PATH
ssh_config()
{
    [[ -z "$1" ]] && return
    [[ -z "$2" ]] && return
    [[ ! -f "$3" ]] && return

    local host user file
    host="$1"
    user="$2"
    file="$3"

    ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no -o ConnectTimeout=5 -o BatchMode=yes "${user}@${host}" < "$file"
}

## ssh_backup HOST USER [FILENAME]
ssh_backup()
{
    [[ -z "$1" ]] && return
    [[ -z "$2" ]] && return

    local host user filename date
    host="$1"
    user="$2"
    filename="${3:-config-file}"
    date="$(date "+%y%m%d_%H%M%S")"

    mkdir -p backups
    ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no -o ConnectTimeout=5 -o BatchMode=yes "${user}@${host}" "show running-config" > backups/${filename}_${date}.cfg
}