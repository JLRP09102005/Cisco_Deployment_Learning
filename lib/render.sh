#!/bin/bash

## render_template TPL_FILE ASSOC_ARRAY_NAME HOST USER
render_template()
{
    [[ -d "$1" ]] && return
    [[ -z "$2" ]] && return
    [[ -z "$3" ]] && return
    [[ -z "$4" ]] && return

    local tmpfile host user

    tmpfile="$(mktemp)" && truncate -s 0 "$tmpfile"
    host="$3"
    user="$4"
    declare -n subs_array="$2"

    [[ "${#subs_array[@]}" -eq 0 ]] && return

    cat "$1" > "$tmpfile"
    trap "rm -f $tmpfile" EXIT

    local marks
    marks="$(grep -o "__.*__" "$tmpfile")"

    while read -r line; do

        if [[ "$line" == "__ENABLESECRET__" ]]; then

            read -s -r -p "Write the password for the privileged mode: " password
            sed "s|$line|$password|g" "$tmpfile"

        elif [[ "$line" == "__USERPASS__" ]]: then
    
            read -s -r -p "Write the password for the new user: " password
            sed "s|$line|$password|g" "$tmpfile"

        else

            sed "s|${line}|${subs_array[$line]}|g" "$tmpfile"

        fi

        [[ ! -z "$password" ]] && unset password

    done <<<"$marks"

    ssh_config "$host" "$user" "$tmpfile"
}