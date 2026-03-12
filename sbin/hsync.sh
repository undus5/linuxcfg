#!/bin/bash

errf() { printf "${@}" >&2 && exit 1; }

usage="Usage: $(basename ${0}) <a|b|d|s|t> <hostname>\n"
hostn="${2}"

case "${1}" in
    a|b|d|t)
        [[ "${1}" =~ ^[abdt]$ ]] || errf "${usage}"
        dir=~/${1}/
        hostip=$(lanip.sh ${hostn})
        [[ -n "${hostip}" ]] || errf "invalid hostname\n"
        rsync -aP --del ${dir} ${hostip}:${dir}
        ;;
    s)
        hostip=$(lanip.sh ${hostn})
        [[ -n "${hostip}" ]] || errf "invalid hostname\n"
        ssh ${hostip}
        ;;
    *)
        errf "${usage}"
        ;;
esac

