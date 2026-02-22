#!/bin/bash

sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))
exec=${sdir}/../apps/ungoogled-chromium/chrome
udir=~/.local/share/chromium-unsafe
args="--disable-web-security --user-data-dir=${udir}"

bgr() { nohup "${@}" &>/dev/null & }

bgr ${exec} ${args} ${@}

