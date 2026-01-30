#!/bin/bash

set -e

kver="${1}"
kdir="${2}"
kimg="/usr/lib/modules/${kver}/vmlinuz"
[[ -f "${kimg}" ]] || kver=$(uname -r)
kimg="/usr/lib/modules/${kver}/vmlinuz"

dracut-install() {
    local stubdir="${1}"
    local vmlinuz=${stubdir}/vmlinuz
    local initrd=${stubdir}/initrd
    install -Dm0644 "${kimg}" "${vmlinuz}"
    dracut --force --hostonly --no-hostonly-cmdline --kver "${kver}" "${initrd}"
}

[[ -d "${kdir}" ]] && dracut-install "${kdir}" && exit 0

findmnt /a &>/dev/null || dracut-install /efi/a
findmnt /b &>/dev/null || dracut-install /efi/b

