#!/bin/bash

errf() { printf "${@}" >&2; exit 1; }
bgr() { nohup "${@}" &>/dev/null & }
chksrv() { pidof "${@}" &>/dev/null; }
chkcmd() { command -v "${@}" &>/dev/null; }

[[ ${EUID} == 0 ]] && errf "abort for root user\n"
chkcmd aria2c || aria2c

start() {
    chksrv aria2c && exit 0
    local ddir=$(realpath ~/Downloads)
    # best_aria2, all_aria2, http_aria2, nohttp_aria2
    local trackers=$(curl -sL "https://cf.trackerslist.com/best_aria2.txt")
    local exec="aria2c --enable-rpc=true --rpc-secret=aria2rpc"
    exec+=" --rpc-listen-port=6800 --bt-stop-timeout=3600"
    exec+=" --dir=${ddir} --bt-tracker=${trackers}"
    bgr ${exec}
}

stop() {
    local pid=$(pidof aria2c)
    [[ -z "${pid}" ]] || echo "${pid}" | xargs kill -9 &>/dev/null
}

case ${1} in
    ""|start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        errf "Usage: $(basename ${0}) <start|stop|restart>\n"
        ;;
esac

