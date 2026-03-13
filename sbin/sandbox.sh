#!/bin/bash

sandbox="${1}"
executable="${2}"
bindexec="${3}"
homedir=$(realpath ~)

errf() { printf "${@}" >&2 && exit 1; }
print_help() { echo "Usage: $(basename $0) <sandbox-dir> <command> [bind]"; }

[[ -z "${sandbox}" || -z "${executable}" ]] && print_help && exit 1
[[ -d "${sandbox}" ]] || errf "$(basename ${sandbox}) not found\n"
if [[ "${bindexec}" == "bind" && -x "${executable}" ]]; then
    executable=$(realpath "${executable}")
    bindexec_opt="--ro-bind ${executable} ${executable}"
fi

bwrap \
  --ro-bind /bin /bin \
  --ro-bind /etc /etc \
  --ro-bind /lib /lib \
  --ro-bind /lib64 /lib64 \
  --ro-bind /sys /sys \
  --ro-bind /usr /usr \
  --dev /dev \
  --dev-bind /dev/dri /dev/dri \
  --proc /proc \
  --tmpfs /tmp \
  --unshare-all \
  --share-net \
  --bind ${sandbox} ${homedir} \
  ${bindexec_opt} ${executable}

