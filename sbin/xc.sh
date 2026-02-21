#!/bin/bash

# errf() { printf "${@}" >&2; exit 1; }

sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))
adir=$(realpath ${sdir}/../apps)

print_help() {
    printf "Usage: $(basename $0) <app_name>\n"
    printf "<app_name>: "; funclist; exit 1
}

funclist() {
    declare -F | grep -Ev "funclist|print_help|bkr|apprun" \
        | awk '{printf "%s ", $3} END {printf "\n"}'
}

bkr() {
    nohup ${@} &>/dev/null &
}

apprun() {
    local apppath="${1}"; shift
    local exec="${adir}/${apppath}"
    [[ -f "${exec}" ]] || print_help
    exec+=" ${@}"
    bkr ${exec}
}

################################################################################

mium() { apprun "ungoogled-chromium/chrome" "${@}"; }
brv() { apprun "brave-browser/brave-browser" "${@}"; }
heli() { apprun "helium-browser/helium" "${@}"; }
zen() { apprun "zen-browser/zen"; }
fox() { apprun "waterfox/waterfox"; }

tg() { apprun "Telegram/Telegram"; }

vsc() { apprun "vscodium/codium" "${@}"; }
subl() { apprun "sublime-text/sublime-text" "${@}"; }
stud() { apprun "android-studio/bin/studio"; }
npn() { apprun "appimages/notepadnext.AppImage" "${@}"; }

los() { apprun "LosslessCut/losslesscut"; }
draw() { apprun "appimages/drawio.AppImage"; }
kden() { apprun "appimages/kdenlive.AppImage"; }
send() { apprun "appimages/localsend.AppImage"; }
dian() { apprun "appimages/obsidian.AppImage"; }
pint() { apprun "appimages/pinta.AppImage"; }

pzip() { apprun "peazip/peazip"; }

eden() { apprun "appimages/eden.AppImage"; }
vcb() { apprun "vcb/vcb.x86_64"; }

vent() { shift; cd ${adir}/ventoy; ./Ventoy2Disk.sh "${@}"; }

offi() {
    local files=()
    for arg in "${@}"; do
        files+=($(realpath "${arg}"))
    done
    apprun "appimages/onlyoffice.AppImage" "${files[@]}";
}

tor() {
    cd "${adir}/tor-browser"
    ./start-tor-browser.desktop --detach
}

mium-unsafe() {
    local udir=$(realpath ~)/.local/share/chromium-unsafe
    apprun "ungoogled-chromium/chrome" \
        "--disable-web-security --user-data-dir=${udir} ${@}"
}

################################################################################

rime() { rm -rf ~/.local/share/fcitx5/rime/build; fcitx5 -d -r &>/dev/null & }
fps() { MANGOHUD_CONFIG="gpu_temp,cpu_temp,frametime=0" bkr mangohud vkcube; }
gbkz() { shift; unzip -O GB18030 "${@}"; }
cam() { bkr mpv av://v4l2:/dev/video0 --profile=low-latency; }
yt() { shift; yt-dlp -S "res:${1}" "${2}"; }

lgc() {
    local bdir=${adir}/looking-glass/build
    [[ -d "${bdir}" ]] && rm -rf "${bdir}"
    mkdir -p "${bdir}" && cd "${bdir}"
    cmake -DENABLE_X11=no -DENABLE_PULSEAUDIO=no ../src/client/ && make
}

iomm() {
    shopt -s nullglob
    for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
        echo "IOMMU Group ${g##*/}:"
        for d in $g/devices/*; do
            echo -e "\t$(lspci -nns ${d##*/})"
        done;
    done;
}

################################################################################

funcname=${1}; shift
[[ -n "${funcname}" ]] || print_help
funclist | grep -q "${funcname} " || print_help
${funcname} "${@}"

