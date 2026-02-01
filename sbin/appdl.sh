#!/bin/bash

mium() { echo "https://ungoogled-software.github.io/ungoogled-chromium-binaries/"; }
brv() { echo "https://github.com/brave/brave-browser/releases/latest"; }
heli() { echo "https://github.com/imputnet/helium-linux/releases/latest"; }
zen() { echo "https://zen-browser.app/download/"; }
fox() { echo "https://www.waterfox.com/download/"; }

vsc() { echo "https://github.com/VSCodium/vscodium/releases/latest"; }
subl() { echo "https://www.sublimetext.com/download"; }
stud() { echo "https://developer.android.com/studio/"; }
npn() { echo "https://github.com/dail8859/NotepadNext/releases/latest"; }

fileb() { echo "https://github.com/filebrowser/filebrowser/releases/latest"; }
halloy() { echo "https://github.com/squidowl/halloy/releases/latest"; }
lg() { echo "https://looking-glass.io/downloads"; }
los() { echo "https://github.com/mifi/lossless-cut/releases/latest"; }
pzip() { echo "https://peazip.github.io/peazip-linux.html"; }
vent() { echo "https://ventoy.net/en/download.html"; }

draw() { echo "https://github.com/jgraph/drawio-desktop/releases/latest"; }
kden() { echo "https://kdenlive.org/download/"; }
send() { echo "https://localsend.org/download"; }
navi() { echo "https://www.navicat.com/en/download/navicat-premium-lite"; }
dian() { echo "https://github.com/obsidianmd/obsidian-releases/releases/latest"; }
offi() { echo "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/latest"; }

eden() { echo "https://github.com/eden-emulator/Releases/releases/latest"; }
citr() { echo "https://git.citron-emu.org/Citron/Emulator/releases"; }

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

xdg-open "${url}"

