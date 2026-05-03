#!/usr/bin/bash

chkcmd() { command -v "${@}" &>/dev/null; }
chksrv() { pidof "${@}" &>/dev/null; }
bgr() { nohup "${@}" &>/dev/null & }

chkcmd kanshi && ! chksrv kanshi && bgr kanshi
chkcmd fcitx5 && ! chksrv fcitx5 && bgr fcitx5 -d -r

polkit_name=polkit-mate-authentication-agent-1
polkit_arch=/usr/lib/mate-polkit/${polkit_name}
polkit_fedora=/usr/libexec/${polkit_name}
[[ -f "${polkit_arch}" ]] && polkit_exec="${polkit_arch}"
[[ -f "${polkit_fedora}" ]] && polkit_exec="${polkit_fedora}"
chkcmd ${polkit_exec} && ! chksrv ${polkit_name} && bgr ${polkit_exec}

chkcmd evars.sh && source $(which evars.sh)
if [[ -d "${bgdir}" ]]; then
    chksrv swaybg && pidof swaybg | xargs kill -9
    bgr swaybg \
        -o "${screen27}" -m fill -i "${bgdir}/screen27.png" \
        -o "${screen15}" -m fill -i "${bgdir}/screen15.png" \
        -o "${screenusb}" -m fill -i "${bgdir}/screenusb.png"
fi

if [[ -n "${SWAYSOCK}" && -d ~/.icons/Bibata-Modern-Ice ]]; then
    swaymsg seat seat0 xcursor_theme Bibata-Modern-Ice 28
fi

if [[ -d ~/.icons/Qogir ]]; then
    gsettings set org.gnome.desktop.interface icon-theme Qogir
fi

