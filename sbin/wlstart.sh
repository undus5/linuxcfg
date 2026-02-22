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

chkcmd wlstart-extra.sh && bkr wlstart-extra.sh

