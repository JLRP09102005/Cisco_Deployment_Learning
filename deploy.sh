#!/bin/bash

## SOURCING FILES
source "lib/log.sh"
source "lib/render.sh"
source "lib/ssh.sh"
source "check_deps.sh"

## CALL INIT FUNCTIONS
log_init
ssh_init

log_ok "ejecutado sin problemas"