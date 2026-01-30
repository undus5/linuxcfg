#!/bin/bash

_chrome() { echo "https://ungoogled-software.github.io/ungoogled-chromium-binaries/"; }
_brave() { echo "https://github.com/brave/brave-browser/releases/latest"; }
_helium() { echo "https://github.com/imputnet/helium-linux/releases/latest"; }
_zen() { echo "https://zen-browser.app/download/"; }
_fox() { echo "https://www.waterfox.com/download/"; }

_vsc() { echo "https://github.com/VSCodium/vscodium/releases/latest"; }
_subl() { echo "https://www.sublimetext.com/download"; }
_studio() { echo "https://developer.android.com/studio/"; }

_fileb() { echo "https://github.com/filebrowser/filebrowser/releases/latest"; }
_halloy() { echo "https://github.com/squidowl/halloy/releases/latest"; }
_glass() { echo "https://looking-glass.io/downloads"; }
_losscut() { echo "https://github.com/mifi/lossless-cut/releases/latest"; }
_zip() { echo "https://peazip.github.io/peazip-linux.html"; }
_ventoy() { echo "https://ventoy.net/en/download.html"; }

_drawio() { echo "https://github.com/jgraph/drawio-desktop/releases/latest"; }
_kden() { echo "https://kdenlive.org/download/"; }
_send() { echo "https://localsend.org/download"; }
_navicat() { echo "https://www.navicat.com/en/download/navicat-premium-lite"; }
_obsidian() { echo "https://github.com/obsidianmd/obsidian-releases/releases/latest"; }
_office() { echo "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/latest"; }

_eden() { echo "https://github.com/eden-emulator/Releases/releases/latest"; }
_citron() { echo "https://git.citron-emu.org/Citron/Emulator/releases"; }

print_help() {
    printf "Usage: $(basename $0) <app_name>\n"
    printf "app_name: "; funclist; exit 1
}

funclist() {
    declare -F | grep -Ev "funclist|print_help" | sed 's/_//g' \
        | awk '{printf "%s ", $3} END {printf "\n"}'
}

_funcname=${1}
funclist | grep -q "${_funcname} " && _url=$(_${_funcname})
[[ -n "${_url}" ]] || print_help

xdg-open "${_url}"

