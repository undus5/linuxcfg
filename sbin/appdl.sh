#!/bin/bash

chrome() { echo "https://ungoogled-software.github.io/ungoogled-chromium-binaries/"; }
chromes() { echo "https://github.com/NeverDecaf/chromium-web-store/releases/latest"; }
brave() { echo "https://versions.brave.com/"; }
helium() { echo "https://github.com/imputnet/helium-linux/releases/latest"; }
waterfox() { echo "https://www.waterfox.com/download/"; }

notepad() { echo "https://github.com/dail8859/NotepadNext/releases/latest"; }

fbrowser() { echo "https://github.com/filebrowser/filebrowser/releases/latest"; }
halloy() { echo "https://github.com/squidowl/halloy/releases/latest"; }
lglass() { echo "https://looking-glass.io/downloads"; }
losscut() { echo "https://github.com/mifi/lossless-cut/releases/latest"; }
pzip() { echo "https://peazip.github.io/peazip-linux.html"; }
ventoy() { echo "https://ventoy.net/en/download.html"; }

drawio() { echo "https://github.com/jgraph/drawio-desktop/releases/latest"; }
send() { echo "https://github.com/localsend/localsend/releases/latest"; }
obsi() { echo "https://github.com/obsidianmd/obsidian-releases/releases/latest"; }
only() { echo "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/latest"; }
pinta() { echo "https://github.com/pkgforge-dev/Pinta-AppImage/releases/latest"; }

plex() { echo "https://github.com/IBM/plex/releases"; }
mapl() { echo "https://github.com/subframe7536/maple-font/releases"; }

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
exec=${sdir}/../apps/brave-browser/brave-browser
${exec} "${url}"

