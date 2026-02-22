#!/usr/bin/bash

errf() { printf "${@}" >&2; exit 1; }
chkcmd() { command -v "${@}" &>/dev/null; }
bgr() { nohup "${@}" &>/dev/null & }

chkcmd evars.sh || errf "evars.sh not found\n"
source $(which evars.sh)

vdir=${resdir}
[[ -d ${vdir} ]] || errf "directory not found: ${vdir}\n"
port=8086

play_media() {
    local request="${1}"
    local relpath=${request:6:-1}
    local fullpath=${vdir}/${relpath}
    local section=$(echo ${relpath} | awk -F "/" '{print $1}')

    case ${section} in
        video|anime3d)
            bgr mpv --player-operation-mode=pseudo-gui "${fullpath}"*
            ;;
        manga|cg)
            [[ -d ${fullpath} ]] || errf "directory not found: ${fullpath}\n"
            local pic0=${fullpath}/_000.jpg
            local pic1=${fullpath}/_001.jpg
            local picf=""
            [[ -f "${pic0}" ]] && picf="${pic0}" || picf="${pic1}"
            bgr swayimg "${picf}" "${fullpath}"
            ;;
    esac
}

check_server() {
    local ppid=$(pgrep $(basename ${0}) | head -n1 | awk '{print $1}')
    local ncid=$(pgrep nc -P ${ppid} | head -n1 | awk '{print $1}')
    [[ -n ${ncid} ]] && exit 0
}

run_server() {
    check_server
    # need 'openbsd-netcat' package
    while true; do
        echo -e "HTTP/1.1 200 OK\r\n" | nc -lN ${port} | \
            grep ^GET | awk '{print $2}' | xargs ${0} play
    done
}

kill_server() {
    local ppid=$(pgrep $(basename ${0}) | head -n1 | awk '{print $1}')
    local ncid=$(pgrep nc -P ${ppid} | head -n1 | awk '{print $1}')
    [[ -n ${ncid} && -n ${ppid} ]] && kill -9 ${ppid}
    [[ -n ${ncid} ]] && kill -9 ${ncid}
}

start_daemon() { bgr ${0} run; }

case ${1} in
    ""|start)
        start_daemon
        ;;
    stop)
        kill_server
        ;;
    restart)
        kill_server; start_daemon
        ;;
    run)
        run_server
        ;;
    play)
        shift; play_media "${@}"
        ;;
    *)
        errf "Usage: $(basename ${0}) <h|s|k>\n"
        ;;
esac

