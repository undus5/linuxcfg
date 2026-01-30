#!/bin/bash

# _sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))
errf() { printf "${@}" >&2; exit 1; }

which evars.sh &>/dev/null || errf "evars.sh not found\n"
source $(which evars.sh)

command_check() {
    command -v ${1} &>/dev/null || errf "command not found: ${1}\n"
}

_devname=${1}
[[ -n "${_devname}" ]] || errf "Usage: $(basename ${0}) <device_name>\n"
# _devmac=_${!_devname}
declare -n _devmac=_${_devname}
[[ -n "${_devmac}" ]] || errf "undefined device: ${_devname}\n"

command_check arp-scan
# ip link | grep brnat | grep -q "state UP" \
#     && arp-scan -x -l -I brnat | grep ${_devmac} | awk '{ print $1 }'
ip link | grep brlan | grep -q "state UP" \
    && arp-scan -x -l -I brlan | grep ${_devmac} | awk '{ print $1 }'

