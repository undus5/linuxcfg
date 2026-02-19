#!/bin/bash

kver="${1}"
dest="${2}"
kimg="/usr/lib/modules/${kver}/vmlinuz"
[[ -f "${kimg}" ]] || exit 1

dracut-install() {
    local stubdir="${1}"
    local vmlinuz=${stubdir}/vmlinuz
    local initrd=${stubdir}/initrd
    install -Dm0644 "${kimg}" "${vmlinuz}"
    dracut --force --hostonly --no-hostonly-cmdline --kver "${kver}" "${initrd}"
}

[[ -d "${dest}" ]] && dracut-install "${dest}" && exit 0

findmnt /a &>/dev/null || dracut-install /efi/a
findmnt /b &>/dev/null || dracut-install /efi/b

