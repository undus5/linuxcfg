#!/bin/bash

term=foot
# term=alacritty

if [[ -d "${1}" ]]; then
    wdir="${1}"; shift
    cmd="${@}"
    if [[ "${term}" == "foot" ]]; then
        foot -D "${wdir}" ${cmd}
    elif [[ "${term}" == "alacritty" ]]; then
        alacritty --working-directory "${wdir}" -e ${cmd}
    fi
elif [[ -n "${@}" ]]; then
    exec="${1}"; shift
    args="${@}"
    if [[ "${term}" == "foot" ]]; then
        foot ${exec} "${args}"
    elif [[ "${term}" == "alacritty" ]]; then
        alacritty -e ${cmd} "${args}"
    fi
else
    if [[ "${term}" == "foot" ]]; then
        foot
    elif [[ "${term}" == "alacritty" ]]; then
        alacritty
    fi
fi

