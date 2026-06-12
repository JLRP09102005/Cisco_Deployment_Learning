#!/bin/bash

## SOURCING FILES
source ".env"
source "lib/log.sh"
source "lib/render.sh"
source "lib/ssh.sh"
source "check_deps.sh"

## CALL INIT FUNCTIONS
log_init
ssh_init

fields=()
index=0
declare -A matrix
while read -r line; do

    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue

    read -ra fields <<< "$line"

    for((i=0;i < ${#fields[@]};i++)); do
        matrix[${index},${i}]="${fields[$i]}"
    done

    ((index++))

done < "inventory.conf"

for((i=0;i < $index;i++)); do

    (
    declare -A device_vars

    file_template=""
    if [[ "${matrix[$i,1]}" == "router" ]]; then
        file_template="${TEMPLATES_DIR}/router_base.tpl"
    elif [[ "${matrix[$i,1]}" == "switch-l3" ]]; then
        file_template="${TEMPLATES_DIR}/switch_l3_base.tpl"
    elif [[ "${matrix[$i,1]}" == "switch-l2" ]]; then
        file_template="${TEMPLATES_DIR}/switch_l2_base.tpl"
    else
        log_error "Type not found for ${matrix[$i,0]}"
        continue
    fi

    [[ -f "${VARS_DIR}/${matrix[$i,2]}.conf" ]] && source "${VARS_DIR}/${matrix[$i,2]}.conf"

    build_device_array "device_vars" "$i" && log_ok "Associative array builded correctly"
    render_and_deploy "$file_template" "device_vars" "${matrix[$i,0]}" "$matrix[$i,3]" && log_ok "Rendered and deployed to the device correctly for host ${matrix[$i,0]}"

    )

done