#!/usr/bin/bash

# https://github.com/francma/wob
# https://gitlab.com/wef/dotfiles/-/blob/master/bin/mywob

print_help() { printf "Usage: $(basename $0) <integer>\n"; }

case "$1" in
    "")
        print_help; exit 1
        ;;
    -h|--help)
        print_help; exit 0
        ;;
esac

[[ "$WAYLAND_DISPLAY" ]] || (command -v wob &>/dev/null) || exit 0
[[ "${1}" ]] && [[ "${1}" =~ ^[0-9]{1,3}$ ]] || exit 0

wob_pipe=~/.cache/${WAYLAND_DISPLAY}.wob
status="false"

for pid in $( pgrep -u "$USER" "^wob$" ); do
    wob_wldisplay="$( tr '\0' '\n' < "/proc/$pid/environ" | \
        awk -F'=' '/^WAYLAND_DISPLAY/ {print $2}' )"
    if [[ "${wob_wldisplay}" == "$WAYLAND_DISPLAY" ]]; then
        status="true"
    fi
done

[[ -p ${wob_pipe} ]] || mkfifo "${wob_pipe}"

[[ "${status}" == "false" ]] && tail -f ${wob_pipe} | wob &

echo "${1}" > ${wob_pipe}

