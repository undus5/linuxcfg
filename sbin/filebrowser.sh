#!/usr/bin/bash

_srcdir=$(dirname $(realpath ${BASH_SOURCE[0]}))
_appdir=$(realpath ${_srcdir}/../apps/filebrowser)

_port=8182
_sharedir=$(realpath ~/Public)
_exec="${_appdir}/filebrowser"
_args="-d ${_appdir}/filebrowser.db -p ${_port} -r ${_sharedir}"

_start() {
    pidof filebrowser &>/dev/null || nohup ${_exec} ${_args} &>/dev/null &
}

_stop() {
    pidof filebrowser | xargs kill &>/dev/null
}

case ${1} in
    ""|start)
        _start
        ;;
    stop)
        _stop
        ;;
    restart)
        _stop && _start
        ;;
    --)
        shift
        ${_exec} ${@}
        ;;
    *)
        printf "Usage: $(basename $0) <start|stop|restart|-->\n"
esac

