#!/bin/bash

## CHECKING COMMAND DEPENDENCES
[[ ! ssh -V > /dev/null ]] && log_error "DEPENDENCES: SSH not installed"
[[ ! mktemp --version > /dev/null ]] && log_error "DEPENDENCES: MKTEMP not installed"
[[ ! date --version > /dev/null ]] && log_error "DEPENDENCES: DATE not installed"

## CHECKING SCRIPT FILE DEPENDENCES


## CHECKING BASH VERSION
[[ "$(echo "${BASH_VERSION:0:1}")" -lt 4 ]] && log_error "BASH INCORRECT VERSION: this software needs at least Bash4+"