#!/bin/bash

hdir=$(realpath $(dirname ${BASH_SOURCE[0]})/../)

export PATH=${hdir}/bin:${hdir}/sbin:$PATH

# https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

alias cdd="cd ~/Downloads"
alias ywd='pwd | tr -d "\n" | wl-copy'

# [[ -z "$WAYLAND_DISPLAY" ]] && [[ "$XDG_VTNR" -eq 1 ]] && exec sway

