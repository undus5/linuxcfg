#!/bin/bash

eprintf() {
    printf "${1}" >&2 && exit 1
}

[[ ${EUID} == 0 ]] && eprintf "abort for root user\n"
command -v aria2c &>/dev/null || aria2c


start() {
    pidof aria2c &>/dev/null && exit 0
    local _ddir=$(realpath ~/Downloads)
    # best_aria2, all_aria2, http_aria2, nohttp_aria2
    local _trackers=$(curl -sL "https://cf.trackerslist.com/best_aria2.txt")
    local _exec="aria2c --enable-rpc=true --rpc-secret=aria2rpc"
    _exec+=" --rpc-listen-port=6800 --bt-stop-timeout=3600"
    _exec+=" --dir=${_ddir} --bt-tracker=${_trackers}"
    nohup ${_exec} &>/dev/null &
}

stop() {
    local _pid=$(pidof aria2c)
    [[ -z "${_pid}" ]] || echo "${_pid}" | xargs kill -9 &>/dev/null
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
