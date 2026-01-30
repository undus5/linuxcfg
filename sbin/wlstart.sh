#!/usr/bin/bash

command -v kanshi &>/dev/null \
    && ! pidof kanshi &>/dev/null \
    && nohup kanshi &>/dev/null &

command -v fcitx5 &>/dev/null \
    && ! pidof fcitx5 &>/dev/null \
    && nohup fcitx5 -d -r &>/dev/null &

polkit_name=polkit-mate-authentication-agent-1
polkit_arch=/usr/lib/mate-polkit/${polkit_name}
polkit_fedora=/usr/libexec/${polkit_name}
[[ -f "${polkit_arch}" ]] && polkit_exec="${polkit_arch}"
[[ -f "${polkit_fedora}" ]] && polkit_exec="${polkit_fedora}"
command -v ${polkit_exec} &>/dev/null \
    && ! pidof ${polkit_name} &>/dev/null \
    && nohup ${polkit_exec} &>/dev/null &

command -v wlstart-custom.sh &>/dev/null \
    && nohup wlstart-custom.sh &>/dev/null &

