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

_bkr() {
    nohup ${@} &>/dev/null &
}

_apprun() {
    local _apppath="${1}"; shift
    local _exec="${_adir}/${_apppath}"
    [[ -f "${_exec}" ]] || print_help
    _exec+=" ${@}"
    _bkr ${_exec}
}

################################################################################

_mium() { _apprun "ungoogled-chromium/chrome" "${@}"; }
_brv() { _apprun "brave-browser/brave-browser" "${@}"; }
_heli() { _apprun "helium/chrome" "${@}"; }
_zen() { _apprun "zen-browser/zen"; }
_fox() { _apprun "waterfox/waterfox"; }

_tg() { _apprun "Telegram/Telegram"; }

_vsc() { _apprun "vscodium/codium" "${@}"; }
_subl() { _apprun "sublime-text/sublime-text" "${@}"; }
_stud() { _apprun "android-studio/bin/studio"; }

_los() { _apprun "LosslessCut/losslesscut"; }
_draw() { _apprun "appimages/drawio.AppImage"; }
_kden() { _apprun "appimages/kdenlive.AppImage"; }
_send() { _apprun "appimages/localsend.AppImage"; }
_dian() { _apprun "appimages/obsidian.AppImage"; }

_pzip() { _apprun "peazip/peazip"; }

_eden() { _apprun "appimages/eden.AppImage"; }
_vcb() { _apprun "vcb/vcb.x86_64"; }

_vent() { shift; cd ${_adir}/ventoy; ./Ventoy2Disk.sh "${@}"; }

_offi() {
    local _files=()
    for _arg in "${@}"; do
        _files+=($(realpath "${_arg}"))
    done
    _apprun "appimages/onlyoffice.AppImage" "${_files[@]}";
}

_tor() {
    cd "${_adir}/tor-browser"
    ./start-tor-browser.desktop --detach
}

_mium-unsafe() {
    local _udir=$(realpath ~)/.local/share/chromium-unsafe
    _apprun "ungoogled-chromium/chrome" \
        "--disable-web-security --user-data-dir=${_udir} ${@}"
}

################################################################################

_rime() { rm -rf ~/.local/share/fcitx5/rime/build; fcitx5 -d -r &>/dev/null & }
_fps() { MANGOHUD_CONFIG="gpu_temp,cpu_temp,frametime=0" _bkr mangohud vkcube; }
_gbkz() { shift; unzip -O GB18030 "${@}"; }
_cam() { _bkr mpv av://v4l2:/dev/video0 --profile=low-latency; }
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

