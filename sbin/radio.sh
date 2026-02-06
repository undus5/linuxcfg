#!/usr/bin/bash

print_help() {
    printf "Usage: $(basename $0) <genre>\n"
    printf "genre: "; funclist; exit 1
}

trance() { mpv http://www.hbr1.com/playlist/trance.ogg.m3u; exit 0; }
tronic() { mpv http://www.hbr1.com/playlist/tronic.ogg.m3u; exit 0; }
ambient() { mpv http://www.hbr1.com/playlist/ambient.ogg.m3u; exit 0; }
huaiji() { mpv http://ls.qingting.fm/live/4804.m3u8; exit 0; }

funclist() {
    declare -F | grep -Ev "funclist|print_help" \
        | awk '{printf "%s ", $3} END {printf "\n"}'
}

funcname=${1}
funclist | grep -q "${funcname}" || print_help
${funcname}

