#!/bin/bash

errf() { printf "${@}" >&2 && exit 1; }

user=u
udir=/home/${user}/a/usr.local/
rdir=/usr/local/

if [[ ${EUID} == 0 ]]; then
    [[ "${1}" == "su" ]] || errf "whoami: $(whoami)\n"
    srcdir=${udir}
    dstdir=${rdir}
else
    [[ "${1}" == "u" ]] || errf "whoami: $(whoami)\n"
    [[ "$(whoami)" == "${user}" ]] || exit 1
    srcdir=${rdir}
    dstdir=${udir}
fi

rsync -aP --del ${srcdir} ${dstdir}

