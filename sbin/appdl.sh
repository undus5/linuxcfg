#!/bin/bash

mium() { echo "https://ungoogled-software.github.io/ungoogled-chromium-binaries/"; }
brav() { echo "https://github.com/brave/brave-browser/releases/latest"; }
heli() { echo "https://github.com/imputnet/helium-linux/releases/latest"; }
fox() { echo "https://www.waterfox.com/download/"; }

vsc() { echo "https://github.com/VSCodium/vscodium/releases/latest"; }
subl() { echo "https://www.sublimetext.com/download"; }
droid() { echo "https://developer.android.com/studio/"; }
txt() { echo "https://github.com/dail8859/NotepadNext/releases/latest"; }

file() { echo "https://github.com/filebrowser/filebrowser/releases/latest"; }
irc() { echo "https://github.com/squidowl/halloy/releases/latest"; }
glass() { echo "https://looking-glass.io/downloads"; }
vcut() { echo "https://github.com/mifi/lossless-cut/releases/latest"; }
pzip() { echo "https://peazip.github.io/peazip-linux.html"; }
vtoy() { echo "https://ventoy.net/en/download.html"; }

draw() { echo "https://github.com/jgraph/drawio-desktop/releases/latest"; }
send() { echo "https://github.com/localsend/localsend/releases/latest"; }
dian() { echo "https://github.com/obsidianmd/obsidian-releases/releases/latest"; }
only() { echo "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/latest"; }
pint() { echo "https://github.com/pkgforge-dev/Pinta-AppImage/releases/latest"; }

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

