#!/usr/bin/bash

errf() { printf "${@}" >&2; exit 1; }

which evars.sh &>/dev/null || errf "evars.sh not found\n"
source $(which evars.sh)

vdir=${resdir}
[[ -d ${vdir} ]] || errf "directory not found: ${vdir}\n"
port=8086

play() {
    local request="${1}"
    local relpath=${request:6:-1}
    local fullpath=${vdir}/${relpath}
    local section=$(echo ${relpath} | awk -F "/" '{print $1}')

    case ${section} in
        video|anime3d)
            nohup mpv --player-operation-mode=pseudo-gui "${fullpath}"* &>/dev/null &
            ;;
        manga|cg)
            [[ -d ${fullpath} ]] || errf "directory not found: ${fullpath}\n"
            if [[ -f ${pic0} ]]; then
                nohup oculante ${fullpath}/_000.jpg &>/dev/null &
            elif [[ -f ${pic1} ]]; then
                nohup oculante ${fullpath}/_001.jpg &>/dev/null &
            fi
            ;;
    esac
}

case ${1} in
    s|server)
        # need 'openbsd-netcat' package
        while true; do
            echo -e "HTTP/1.1 200 OK\r\n" | nc -lN ${port} | \
                grep ^GET | awk '{print $2}' | xargs ${0} play
        done
        ;;
    p|play)
        play ${2}
        ;;
    *)
        errf "Usage: $(basename ${0}) <s|p>\n"
        ;;
esac
