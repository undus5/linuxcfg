#!/usr/bin/bash

chkcmd() { command -v "${@}" &>/dev/null; }
chksrv() { pidof "${@}" &>/dev/null; }
bkr() { nohup "${@}" &>/dev/null & }

chkcmd kanshi && ! chksrv kanshi && bkr hanshi
chkcmd fcitx5 && ! chksrv fcitx5 && bkr fcitx5 -d -r

polkit_name=polkit-mate-authentication-agent-1
polkit_arch=/usr/lib/mate-polkit/${polkit_name}
polkit_fedora=/usr/libexec/${polkit_name}
[[ -f "${polkit_arch}" ]] && polkit_exec="${polkit_arch}"
[[ -f "${polkit_fedora}" ]] && polkit_exec="${polkit_fedora}"
chkcmd ${polkit_exec} && ! chksrv ${polkit_name} && bkr ${polkit_exec}

chkcmd evars.sh && source $(which evars.sh)
if [[ -d "${bgdir}" ]]; then
    chksrv swaybg && pidof swaybg | xargs kill -9
    bgr swaybg \
        -o "${dell27}" -m fill -i "${bgdir}/dell27.png" \
        -o "${port15}" -m fill -i "${bgdir}/port15.png" \
        -o "${usbhdmi}" -m fill -i "${bgdir}/usbhdmi.png"
fi

