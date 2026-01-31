#!/bin/bash

set -e

errf() { printf "${@}" >&2 && exit 1; }

[[ ${EUID} == 0 ]] || errf "run as root\n"

sdir=$(realpath $(dirname ${BASH_SOURCE[0]})/../)

srvname=${1}
[[ -n "${srvname}" ]] || errf "Usage: $(basename $0) <srvname>\n"

cd /usr/local/cfg/
ln -sf ./pool/naiveproxy-${srvname}.json ./naiveproxy.json
ln -sf ./pool/gost-uot-${srvname}.yml ./gost-uot-tproxy.yml

systemctl restart naiveproxy@* gost-tcp-tproxy@* gost-uot-tproxy@* smartdns

