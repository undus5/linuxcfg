#!/bin/bash

errf() { printf "${@}" >&2; exit 1; }

which evars.sh &>/dev/null || errf "evars.sh not found\n"
source $(which evars.sh)

command_check() {
    command -v ${1} &>/dev/null || errf "command not found: ${1}\n"
}

devname="${1}"
[[ -n "${devname}" ]] || errf "Usage: $(basename ${0}) <device_name>\n"
# devmac=${!devname}
declare -n devmac=${devname}
[[ -n "${devmac}" ]] || errf "undefined device: ${devname}\n"

command_check arp-scan
# ip link | grep brnat | grep -q "state UP" \
#     && arp-scan -x -l -I brnat | grep ${devmac} | awk '{ print $1 }'
ip link | grep brlan | grep -q "state UP" \
    && arp-scan -x -l -I brlan | grep ${devmac} | awk '{ print $1 }'

