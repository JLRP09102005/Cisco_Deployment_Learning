#!/bin/bash

## render_template TPL_FILE ASSOC_ARRAY_NAME HOST USER
render_template()
{
    [[ ! -f "$1" ]] && return
    [[ -z "$2" ]] && return
    [[ -z "$3" ]] && return
    [[ -z "$4" ]] && return

    local tmpfile host user

    tmpfile="$(mktemp)"
    trap "rm -f $tmpfile" EXIT
    host="$3"
    user="$4"
    declare -n subs_array="$2"

    [[ "${#subs_array[@]}" -eq 0 ]] && return

    cat "$1" > "$tmpfile"

    local marks
    marks="$(grep -o "__.*__" "$tmpfile")"

    while read -r line; do

        if [[ "$line" =~ "^__SECRET:(.+)__$" ]]; then
        
            secret_name="${BASH_REMATCH[1]}"
            read -s -r -p "Write the password for $secret_name: " password
            sed -i "s|$line|$password|g" "$tmpfile"
            unset password

        else

            sed -i "s|${line}|${subs_array[$line]}|g" "$tmpfile"

        fi

    done <<<"$marks"

    ssh_config "$host" "$user" "$tmpfile"
    rm -f "$tmpfile"
}