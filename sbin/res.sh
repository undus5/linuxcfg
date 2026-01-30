#!/usr/bin/bash

errf() { printf "${@}" >&2; exit 1; }

which evars.sh &>/dev/null || errf "evars.sh not found\n"
source $(which evars.sh)

_vdir=${_resdir}
[[ -d ${_vdir} ]] || errf "directory not found: ${_vdir}\n"
_port=8084

play() {
    _request=${1}
    _relpath=${_request:6:-1}

    _fullpath=${_vdir}/${_relpath}

    _section=$(echo ${_relpath} | awk -F "/" '{print $1}')
    case ${_section} in
        video|anime3d)
            nohup mpv --player-operation-mode=pseudo-gui "${_fullpath}"* &>/dev/null &
            ;;
        manga|cg)
            [[ -d ${_fullpath} ]] || errf "directory not found: ${_fullpath}\n"
            if [[ -f ${_pic0} ]]; then
                nohup oculante ${_fullpath}/_000.jpg &>/dev/null &
            elif [[ -f ${_pic1} ]]; then
                nohup oculante ${_fullpath}/_001.jpg &>/dev/null &
            fi
            ;;
    esac
}

case ${1} in
    s|server)
        # need 'openbsd-netcat' package
        while true; do
            echo -e "HTTP/1.1 200 OK\r\n" | nc -lN ${_port} | \
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
