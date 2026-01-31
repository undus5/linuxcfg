#!/bin/bash

sdir=$(realpath $(dirname ${BASH_SOURCE[0]})/../)

# https://raw.githubusercontent.com/17mon/china_ip_list/refs/heads/master/china_ip_list.txt
china_ip_file=${sdir}/share/tunn/china_ip_list.txt
nft_tpl_file=${sdir}/share/tunn/tunn.tpl.nft

format_list() {
    sed -e '/^$/d' \
        -e '/.*:.*/d' \
        -e 's/^/            /g' -e 's/$/,/g' ${1}
}

ip_china_tmp=$(mktemp)
format_list ${china_ip_file} > ${ip_china_tmp}

cat ${nft_tpl_file} |\
    sed "/__IPSET2__/r ${ip_china_tmp}" | sed -e "/__IPSET2__/d"

rm ${ip_china_tmp}

