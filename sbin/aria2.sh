#!/bin/bash

eprintf() {
    printf "${1}" >&2 && exit 1
}

[[ ${EUID} == 0 ]] && eprintf "abort for root user\n"
command -v aria2c &>/dev/null || aria2c


start() {
    pidof aria2c &>/dev/null && exit 0
    local ddir=$(realpath ~/Downloads)
    # best_aria2, all_aria2, http_aria2, nohttp_aria2
    local trackers=$(curl -sL "https://cf.trackerslist.com/best_aria2.txt")
    local exec="aria2c --enable-rpc=true --rpc-secret=aria2rpc"
    exec+=" --rpc-listen-port=6800 --bt-stop-timeout=3600"
    exec+=" --dir=${ddir} --bt-tracker=${trackers}"
    nohup ${exec} &>/dev/null &
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
        eprintf "Usage: $(basename ${0}) <start|stop|restart>\n"
        ;;
esac
