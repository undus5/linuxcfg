#!/bin/bash

set -e

errf() { printf "${@}" >&2; exit 1; }

which evars.sh &>/dev/null || errf "evars.sh not found\n"
source $(which evars.sh)

_imgdir=${_bgdir}
[[ -d "${_imgdir}" ]] || errf "directory not found: ${_imgdir}\n"

pidof swaybg &>/dev/null && pidof swaybg | xargs kill -9
nohup swaybg \
    -o "${_dell27}" -m fill -i "${_imgdir}/dell27.png" \
    -o "${_port15}" -m fill -i "${_imgdir}/port15.png" \
    -o "${_usbhdmi}" -m fill -i "${_imgdir}/usbhdmi.png" \
    &>/dev/null &

