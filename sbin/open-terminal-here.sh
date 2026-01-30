#!/bin/bash

_term=foot
# _term=alacritty

if [[ -d "${1}" ]]; then
    _wdir="${1}"; shift
    _cmd="${@}"
    if [[ "${_term}" == "foot" ]]; then
        foot -D "${_wdir}" ${_cmd}
    elif [[ "${_term}" == "alacritty" ]]; then
        alacritty --working-directory "${_wdir}" -e ${_cmd}
    fi
elif [[ -n "${@}" ]]; then
    _exec="${1}"; shift
    _args="${@}"
    if [[ "${_term}" == "foot" ]]; then
        foot ${_exec} "${_args}"
    elif [[ "${_term}" == "alacritty" ]]; then
        alacritty -e ${_cmd} "${_args}"
    fi
else
    if [[ "${_term}" == "foot" ]]; then
        foot
    elif [[ "${_term}" == "alacritty" ]]; then
        alacritty
    fi
fi

