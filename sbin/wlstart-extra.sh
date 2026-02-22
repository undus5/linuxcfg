#!/bin/bash

set -e

errf() { printf "${@}" >&2; exit 1; }
chkcmd() { command -v "${@}" &>/dev/null; }
chksrv() { pidof "${@}" &>/dev/null; }
bgr() { nohup "${@}" &>/dev/null & }

chkcmd evars.sh || errf "evars.sh not found\n"
source $(which evars.sh)

imgdir=${bgdir}
[[ -d "${imgdir}" ]] || errf "directory not found: ${imgdir}\n"

chksrv swaybg && pidof swaybg | xargs kill -9
bgr swaybg \
    -o "${dell27}" -m fill -i "${imgdir}/dell27.png" \
    -o "${port15}" -m fill -i "${imgdir}/port15.png" \
    -o "${usbhdmi}" -m fill -i "${imgdir}/usbhdmi.png"

