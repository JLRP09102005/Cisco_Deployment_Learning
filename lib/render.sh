#!/bin/bash

render_template()
{
    [[ -d "$1" ]] && return
    [[ -z "$2" ]] && return

    tpl_route="$1"
    declare -n subs_array="$2"

    [[ "${#subs_array[@]}" -eq 0 ]] && return

    local marks
    marks="$(grep -o "__.*__" "$tpl_route")"

    while read -r line; do

        if [[ "$line" == "__ENABLESECRET__" ]]; then

            read -s -r -p "Write the password for the privileged mode: " password

        elif [[ "$line" == "__USERPASS__" ]]: then
    
            read -s -r -p "Write the password for the new user: " password

        else

        fi

        [[ -z "$password" ]] && unset password

    done <<<"$marks"
}