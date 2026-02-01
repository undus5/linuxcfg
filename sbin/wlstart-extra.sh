#!/bin/bash

set -e

errf() { printf "${@}" >&2; exit 1; }

which evars.sh &>/dev/null || errf "evars.sh not found\n"
source $(which evars.sh)

imgdir=${bgdir}
[[ -d "${imgdir}" ]] || errf "directory not found: ${imgdir}\n"

pidof swaybg &>/dev/null && pidof swaybg | xargs kill -9
nohup swaybg \
    -o "${dell27}" -m fill -i "${imgdir}/dell27.png" \
    -o "${port15}" -m fill -i "${imgdir}/port15.png" \
    -o "${usbhdmi}" -m fill -i "${imgdir}/usbhdmi.png" \
    &>/dev/null &

