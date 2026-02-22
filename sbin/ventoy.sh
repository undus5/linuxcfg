#!/bin/bash

sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))

cd ${sdir}/../apps/ventoy
./Ventoy2Disk.sh "${@}"

