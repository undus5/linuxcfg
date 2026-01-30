#!/bin/bash

set -e

errf() { printf "${@}" >&2 && exit 1; }

[[ ${EUID} == 0 ]] || errf "run as root\n"

sdir=$(realpath $(dirname ${BASH_SOURCE[0]})/../)

srvname=${1}
[[ -n "${srvname}" ]] || errf "Usage: $(basename $0) <srvname>\n"

naiveconf=${sdir}/etc/tunnpool/naiveproxy-${srvname}.json
gostconf=${sdir}/etc/tunnpool/gost-uot-${srvname}.yml

ln -sf ${naiveconf} ${sdir}/etc/naiveproxy.json
ln -sf ${gostconf} ${sdir}/etc/gost-uot-tproxy.yml

systemctl restart naiveproxy@* gost-tcp-tproxy@* gost-uot-tproxy@* smartdns

