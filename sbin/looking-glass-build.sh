#!/bin/bash

sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))
bdir=${sdir}/../apps/looking-glass/build

[[ -d "${bdir}" ]] && rm -rf "${bdir}"
mkdir -p "${bdir}" && cd "${bdir}"
cmake -DENABLE_X11=no -DENABLE_PULSEAUDIO=no ../src/client/ && make

