#!/bin/bash

brave() { echo "https://versions.brave.com/"; }
chrome() { echo "https://ungoogled-software.github.io/ungoogled-chromium-binaries/"; }
chromes() { echo "https://github.com/NeverDecaf/chromium-web-store/releases/latest"; }
helium() { echo "https://github.com/imputnet/helium-linux/releases/latest"; }
waterfox() { echo "https://www.waterfox.com/download/"; }

zed() { echo "https://github.com/zed-industries/zed/releases/latest"; }
litexl() { echo "https://github.com/lite-xl/lite-xl/releases/latest"; }

fbrowser() { echo "https://github.com/filebrowser/filebrowser/releases/latest"; }
halloy() { echo "https://github.com/squidowl/halloy/releases/latest"; }
lglass() { echo "https://looking-glass.io/downloads"; }
lossless() { echo "https://github.com/mifi/lossless-cut/releases/latest"; }
pzip() { echo "https://peazip.github.io/peazip-linux.html"; }
ventoy() { echo "https://ventoy.net/en/download.html"; }

drawio() { echo "https://github.com/jgraph/drawio-desktop/releases/latest"; }
lsend() { echo "https://github.com/localsend/localsend/releases/latest"; }
obsid() { echo "https://github.com/obsidianmd/obsidian-releases/releases/latest"; }
onlyoff() { echo "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/latest"; }
pinta() { echo "https://github.com/pkgforge-dev/Pinta-AppImage/releases/latest"; }

ibmplex() { echo "https://github.com/IBM/plex/releases"; }
maplefont() { echo "https://github.com/subframe7536/maple-font/releases"; }

print_help() {
    printf "Usage: $(basename $0) <app_name>\n"
    printf "app_name: "; funclist; exit 1
}

funclist() {
    declare -F | grep -Ev "funclist|print_help" \
        | awk '{printf "%s ", $3} END {printf "\n"}'
}

funcname=${1}
funclist | grep -q "${funcname} " && url=$(${funcname})
[[ -n "${url}" ]] || print_help

sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))
exec=${sdir}/../apps/helium/helium
${exec} "${url}"

