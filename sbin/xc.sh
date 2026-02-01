#!/bin/bash

# errf() { printf "${@}" >&2; exit 1; }

_sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))
_adir=$(realpath ${_sdir}/../apps)

print_help() {
    printf "Usage: $(basename $0) <app_name>\n"
    printf "<app_name>: "; funclist | sed 's/_//g'; exit 1
}

funclist() {
    declare -F | grep -Ev "funclist|print_help|apprun|bkr" \
        | awk '{printf "%s ", $3} END {printf "\n"}'
}

bkr() {
    nohup ${@} &>/dev/null &
}

apprun() {
    local _apppath="${1}"; shift
    local _exec="${_adir}/${_apppath}"
    [[ -f "${_exec}" ]] || print_help
    _exec+=" ${@}"
    bkr ${_exec}
}

################################################################################

_mium() { apprun "ungoogled-chromium/chrome" "${@}"; }
_brv() { apprun "brave-browser/brave-browser" "${@}"; }
_heli() { apprun "helium-browser/helium" "${@}"; }
_zen() { apprun "zen-browser/zen"; }
_fox() { apprun "waterfox/waterfox"; }

_tg() { apprun "Telegram/Telegram"; }

_vsc() { apprun "vscodium/codium" "${@}"; }
_subl() { apprun "sublime-text/sublime-text" "${@}"; }
_stud() { apprun "android-studio/bin/studio"; }
_npn() { apprun "appimages/notepadnext.AppImage" "${@}"; }

_los() { apprun "LosslessCut/losslesscut"; }
_draw() { apprun "appimages/drawio.AppImage"; }
_kden() { apprun "appimages/kdenlive.AppImage"; }
_send() { apprun "appimages/localsend.AppImage"; }
_dian() { apprun "appimages/obsidian.AppImage"; }

_pzip() { apprun "peazip/peazip"; }

_eden() { apprun "appimages/eden.AppImage"; }
_vcb() { apprun "vcb/vcb.x86_64"; }

_vent() { shift; cd ${_adir}/ventoy; ./Ventoy2Disk.sh "${@}"; }

_offi() {
    local _files=()
    for _arg in "${@}"; do
        _files+=($(realpath "${_arg}"))
    done
    apprun "appimages/onlyoffice.AppImage" "${_files[@]}";
}

_tor() {
    cd "${_adir}/tor-browser"
    ./start-tor-browser.desktop --detach
}

_mium-unsafe() {
    local _udir=$(realpath ~)/.local/share/chromium-unsafe
    apprun "ungoogled-chromium/chrome" \
        "--disable-web-security --user-data-dir=${_udir} ${@}"
}

################################################################################

_rime() { rm -rf ~/.local/share/fcitx5/rime/build; fcitx5 -d -r &>/dev/null & }
_fps() { MANGOHUD_CONFIG="gpu_temp,cpu_temp,frametime=0" bkr mangohud vkcube; }
_gbkz() { shift; unzip -O GB18030 "${@}"; }
_cam() { bkr mpv av://v4l2:/dev/video0 --profile=low-latency; }
_yt() { shift; yt-dlp -S "res:${1}" "${2}"; }

_lgc() {
    local _bdir=${_adir}/looking-glass/build
    [[ -d "${_bdir}" ]] && rm -rf "${_bdir}"
    mkdir -p "${_bdir}" && cd "${_bdir}"
    cmake -DENABLE_X11=no -DENABLE_PULSEAUDIO=no ../src/client/ && make
}

_iomm() {
    shopt -s nullglob
    for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
        echo "IOMMU Group ${g##*/}:"
        for d in $g/devices/*; do
            echo -e "\t$(lspci -nns ${d##*/})"
        done;
    done;
}

################################################################################

_funcname=${1}; shift
funclist | grep -q "_${_funcname} " || print_help
_${_funcname} "${@}"

