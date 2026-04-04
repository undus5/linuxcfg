#!/bin/bash

errf() { printf "${@}" >&2 && exit 1; }

usage="Usage: $(basename ${0}) <hostname> <a|b|d|t|s>\n"
hostn="${1}"
opts="${2}"

dsync() {
    # [[ "${1}" =~ ^[abdt]$ ]] || errf "${usage}"
    dir=~/${1}/
    hostip=$(lanip.sh ${hostn})
    [[ -n "${hostip}" ]] || errf "invalid hostname\n"
    rsync -aP --del ${dir} ${hostip}:${dir}
}

case "${opts}" in
    s)
        hostip=$(lanip.sh ${hostn})
        [[ -n "${hostip}" ]] || errf "invalid hostname\n"
        ssh ${hostip}
        ;;
    *)
        # empty check
        [[ -n "${opts}" ]] || errf "${usage}"
        # remove duplicates
        opts=$(echo "${opts}" | grep -o . | sort -u | tr -d '\n')
        # validate opts
        [[ "${opts}" =~ ^[abdt]+$ ]] || errf "${usage}"
        # split opts
        for (( i=0; i<${#opts}; i++ )); do
            d="${opts:i:1}"
            [[ "${d}" =~ ^[abdt]$ ]] || errf "${usage}"
            dsync "${d}"
        done
        ;;
esac

