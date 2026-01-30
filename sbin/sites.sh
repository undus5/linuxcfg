#!/bin/bash

errf() { printf "${@}" >&2; exit 1; }

which evars.sh &>/dev/null || errf "evars.sh not found\n"
source $(which evars.sh)

_sdir=${_sitesdir}
[[ -d "${_sdir}" ]] || errf "directory not found: ${_sdir}\n"
_exec="hugo -D --watch"

stop() {
    local _pids=$(pidof hugo)
    [[ -n "${_pids}" ]] && echo "${_pids}" | xargs kill
}

start() {
    local _pids=$(pidof hugo)
    [[ -n "${_pids}" ]] && exit 0
    cd ${_sdir}/blog
    nohup ${_exec} &>/dev/null &
    cd ${_sdir}/drafts
    nohup ${_exec} &>/dev/null &
    cd ${_sdir}/res
    nohup ${_exec} &>/dev/null &
    cd ${_sdir}/hugo-pure
    nohup ./demo.sh -b --watch &>/dev/null &
}

case ${1} in
    ""|start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop && start
        ;;
esac
