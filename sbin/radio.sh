#!/usr/bin/bash

print_help() {
    printf "Usage: $(basename $0) <genre>\n"
    printf "genre: "; funclist; exit 1
}

_trance() { mpv http://www.hbr1.com/playlist/trance.ogg.m3u; exit 0; }
_tronic() { mpv http://www.hbr1.com/playlist/tronic.ogg.m3u; exit 0; }
_ambient() { mpv http://www.hbr1.com/playlist/ambient.ogg.m3u; exit 0; }
_huaiji() { mpv http://ls.qingting.fm/live/4804.m3u8; exit 0; }

funclist() {
    declare -F | grep -Ev "funclist|print_help" | sed 's/_//g' \
        | awk '{printf "%s ", $3} END {printf "\n"}'
}

_funcname=${1}
funclist | grep -q " ${_funcname} " || print_help
_${_funcname}

