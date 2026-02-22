#!/bin/bash

errf() { printf "${@}" >&2; exit 1; }
chkcmd() { command -v "${@}" &>/dev/null; }

chkcmd evars.sh || errf "evars.sh not found\n"
source $(which evars.sh)

devname="${1}"
[[ -n "${devname}" ]] || errf "Usage: $(basename ${0}) <device_name>\n"
# devmac=${!devname}
declare -n devmac=${devname}
[[ -n "${devmac}" ]] || errf "undefined device: ${devname}\n"

chkcmd arp-scan || errf "command not found: arp-scan\n"
# ip link | grep brnat | grep -q "state UP" \
#     && arp-scan -x -l -I brnat | grep ${devmac} | awk '{ print $1 }'
ip link | grep brlan | grep -q "state UP" \
    && arp-scan -x -l -I brlan | grep ${devmac} | awk '{ print $1 }'

