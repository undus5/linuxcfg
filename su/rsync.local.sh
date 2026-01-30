#!/bin/bash

sdir=$(realpath $(dirname ${BASH_SOURCE[0]}))
tdir=${sdir}/usr.local

[[ -d "${tdir}" ]] || mkdir -p "${tdir}"

rsync -aP --del /usr/local/ "${tdir}"

