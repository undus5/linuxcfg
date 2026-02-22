#!/usr/bin/bash

sharedir=$(realpath ~/Public)
port=8182
dbfile=~/b/sites/filebrowser/filebrowser.db

chksrv() { pidof "${@}" &>/dev/null; }
bgr() { nohup "${@}" &>/dev/null & }

start() {
    local exec="filebrowser -d ${dbfile} -p ${port} -r ${sharedir}"
    chksrv filebrowser || bgr ${exec}
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
        filebrowser ${@}
        ;;
    *)
        printf "Usage: $(basename $0) <start|stop|restart|-->\n"
esac

