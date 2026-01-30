#!/usr/bin/bash

set -e

errf() { printf "${@}" >&2 && exit 1; }

[[ ${EUID} == 0 ]] || errf "need root priviledge\n"

case ${1} in
    ab)
        _srcname=a
        _dstname=b
        ;;
    ba)
        _srcname=b
        _dstname=a
        ;;
    *)
        errf "Usage: $(basename ${0}) <ab|ba>\n"
        ;;
esac

_dstvol_alert="abort: you are running under '@${_dstname}' subvolume now\n"
findmnt /${_srcname} &>/dev/null && errf "${_dstvol_alert}"
findmnt /${_dstname} &>/dev/null || errf "${_dstvol_alert}"

printf "==> Copy vmlinuz and initrd from '@${_srcname}' to '@${_dstname}'\n"
_stubsrc=/efi/boot${_srcname}
_stubdst=/efi/boot${_dstname}
_stubtmp=/efi/boott
[[ -d ${_stubdst} ]] && mv ${_stubdst} ${_stubtmp}
[[ -d ${_stubsrc} ]] && cp -r ${_stubsrc} ${_stubdst}
[[ -d ${_stubtmp} ]] && rm -rf ${_stubtmp}

_dstvol=/${_dstname}/@

# this step makes the snapshot writable in case it is readonly
[[ -d ${_dstvol} ]] && btrfs prop set -f -ts ${_dstvol} ro false

printf "==> "
[[ -d ${_dstvol} ]] && btrfs subvolume delete ${_dstvol}

printf "==> "
btrfs subvolume snapshot / ${_dstvol}

printf "==> Tweak fstab in '/${_dstname}/@'\n"
sed -i -r \
    -e "s#/${_dstname}#/${_srcname}#" \
    -e "s#@${_dstname}\s+0#@${_srcname}   0#" \
    -e "s#@${_srcname}/@#@${_dstname}/@#" \
    ${_dstvol}/etc/fstab

_time=$(date +%Y%m%d.%H%M%S)
_timetxt=/${_dstname}/timestamp.${_time}.txt
printf "==> Create ${_timetxt}\n"
rm /${_dstname}/*.txt
printf "${_time}\n" > ${_timetxt}

