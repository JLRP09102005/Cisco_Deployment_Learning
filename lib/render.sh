#!/bin/bash

## render_template TPL_FILE ASSOC_ARRAY_NAME HOST USER
render_and_deploy()
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

## build_device_array ASSOC_ARRAY_NAME ASSOC_MATRIX_NAME DEVICE_INDEX
build_device_array()
{
    local -n arr="$1"
    local -n mat="$2"
    local i=
    i="$3"
    [[ -z "$arr" ]] && {log_error "build_device_array has no assoc array arg"; exit 1;}
    [[ -z "$mat" ]] && {log_error "build_device_array has no matrix arg"; exit 1;}
    [[ -z "$i" || "$i" -le 0 ]] && {log_error "build_device_array has no index arg or is below/equal 0"; exit 1;}

    [[ ! -z "$HOSTNAME" ]] && arr[__HOSTNAME__]="$HOSTNAME"
    [[ ! -z "$DOMAIN"]] && arr[__DOMAIN__]="$DOMAIN"
    arr[__USER__]="${mat[$i,3]}"
    [[ ! -z "$MOTDBANNER" ]] && arr[__MOTDBANNER__]="$MOTDBANNER"
    [[ ! -z "$NTPSERVER" ]] && arr[__NTPSERVER__]="$NTPSERVER"

    arr[__OSPFID__]="${matrix[$i,0]}"

    [[ ! -z "$VTPDOMAIN" ]] && arr[__VTPDOMAIN__]="$VTPDOMAIN"

    [[ ! -z "$SVI_VLAN10_IP" ]] && arr[__SVI_10_IP__]="$SVI_VLAN10_IP"
    [[ ! -z "$SVI_VLAN10_MASK" ]] && arr[__SVI_10_MASK__]="$SVI_VLAN10_MASK"
    [[ ! -z "$SVI_VLAN20_IP" ]] && arr[__SVI_20_IP__]="$SVI_VLAN20_IP"
    [[ ! -z "$SVI_VLAN20_MASK" ]] && arr[__SVI_20_MASK__]="$SVI_VLAN20_MASK"
    [[ ! -z "$SVI_VLAN30_IP" ]] && arr[__SVI_30_IP__]="$SVI_VLAN30_IP"
    [[ ! -z "$SVI_VLAN30_MASK" ]] && arr[__SVI_30_MASK__]="$SVI_VLAN30_MASK"
    [[ ! -z "$SVI_VLAN40_IP" ]] && arr[__SVI_40_IP__]="$SVI_VLAN40_IP"
    [[ ! -z "$SVI_VLAN40_MASK" ]] && arr[__SVI_40_MASK__]="$SVI_VLAN40_MASK"
    [[ ! -z "$SVI_VLAN99_IP" ]] && arr[__SVI_99_IP__]="$SVI_VLAN99_IP"
    [[ ! -z "$SVI_VLAN99_MASK" ]] && arr[__SVI_99_MASK__]="$SVI_VLAN99_MASK"

    [[ ! -z "$OSPF_AREA_VLAN10" ]] && arr[__OSPF_AREA_VLAN10__]="$OSPF_AREA_VLAN10"
    [[ ! -z "$OSPF_AREA_VLAN20" ]] && arr[__OSPF_AREA_VLAN20__]="$OSPF_AREA_VLAN20"
    [[ ! -z "$OSPF_AREA_VLAN30" ]] && arr[__OSPF_AREA_VLAN30__]="$OSPF_AREA_VLAN30"
    [[ ! -z "$OSPF_AREA_VLAN40" ]] && arr[__OSPF_AREA_VLAN40__]="$OSPF_AREA_VLAN40"
    [[ ! -z "$OSPF_AREA_VLAN99" ]] && arr[__OSPF_AREA_VLAN99__]="$OSPF_AREA_VLAN99"

    [[ ! -z "$HSRP_VLAN10_IP" ]] && arr[__HSRP_GROUP1_IP__]="$HSRP_VLAN10_IP"
    [[ ! -z "$HSRP_VLAN20_IP" ]] && arr[__HSRP_GROUP2_IP__]="$HSRP_VLAN20_IP"
    [[ ! -z "$HSRP_VLAN30_IP" ]] && arr[__HSRP_GROUP3_IP__]="$HSRP_VLAN30_IP"
    [[ ! -z "$HSRP_VLAN40_IP" ]] && arr[__HSRP_GROUP4_IP__]="$HSRP_VLAN40_IP"

    [[ ! -z "$HSRP_PRIORITY_VLAN10" ]] && arr[__HSRP_GROUP1_PRIORITY__]="$HSRP_PRIORITY_VLAN10"
    [[ ! -z "$HSRP_PRIORITY_VLAN20" ]] && arr[__HSRP_GROUP2_PRIORITY__]="$HSRP_PRIORITY_VLAN20"
    [[ ! -z "$HSRP_PRIORITY_VLAN30" ]] && arr[__HSRP_GROUP3_PRIORITY__]="$HSRP_PRIORITY_VLAN30"
    [[ ! -z "$HSRP_PRIORITY_VLAN40" ]] && arr[__HSRP_GROUP4_PRIORITY__]="$HSRP_PRIORITY_VLAN40"

    [[ ! -z "$STP_VLAN10" ]] && arr[__STP_VLAN10_PRIORITY__]="$STP_VLAN10"
    [[ ! -z "$STP_VLAN20" ]] && arr[__STP_VLAN20_PRIORITY__]="$STP_VLAN20"
    [[ ! -z "$STP_VLAN30" ]] && arr[__STP_VLAN30_PRIORITY__]="$STP_VLAN30"
    [[ ! -z "$STP_VLAN40" ]] && arr[__STP_VLAN40_PRIORITY__]="$STP_VLAN40"
    [[ ! -z "$STP_VLAN99" ]] && arr[__STP_VLAN99_PRIORITY__]="$STP_VLAN99"

    [[ ! -z "$DEFAILT_GATEWAY" ]] && arr[__DEFAULT_GATEWAY__]="$DEFAULT_GATEWAY"
}