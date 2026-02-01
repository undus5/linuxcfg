#!/usr/bin/bash

sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))
adir=$(realpath ${sdir}/../apps/filebrowser)

port=8182
sharedir=$(realpath ~/Public)

exec="${adir}/filebrowser"
args="-d ${adir}/filebrowser.db -p ${port} -r ${sharedir}"

start() {
    pidof filebrowser &>/dev/null || nohup ${exec} ${args} &>/dev/null &
}

stop() {
    pidof filebrowser | xargs kill &>/dev/null
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
    --)
        shift
        ${exec} ${@}
        ;;
    *)
        printf "Usage: $(basename $0) <start|stop|restart|-->\n"
esac

