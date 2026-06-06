#!/bin/bash

render_template()
{
    [[ -d "$1" ]] && return
    [[ -z "$2" ]] && return

    tmpfile="$(mktemp)" && truncate -s 0 "$tmpfile"
    declare -n subs_array="$2"

    [[ "${#subs_array[@]}" -eq 0 ]] && return

    cat "$1" > "$tmpfile"

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
}