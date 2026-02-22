#!/bin/bash

errf() { printf "${@}" >&2; exit 1; }
bgr() { nohup "${@}" &>/dev/null & }
chkcmd() { command -v "${@}" &>/dev/null; }

chkcmd evars.sh || errf "evars.sh not found\n"
source $(which evars.sh)

sdir=${sitesdir}
[[ -d "${sdir}" ]] || errf "directory not found: ${sdir}\n"
exec="hugo -D --watch"

stop() {
    local pids=$(pidof hugo)
    [[ -n "${pids}" ]] && echo "${pids}" | xargs kill
}

start() {
    local pids=$(pidof hugo)
    [[ -n "${pids}" ]] && exit 0
    cd ${sdir}/blog && bgr ${exec}
    cd ${sdir}/drafts && bgr ${exec}
    cd ${sdir}/res && bgr ${exec}
    cd ${sdir}/hugo-pure && bgr ./demo.sh -b --watch
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

