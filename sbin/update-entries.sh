#!/bin/bash

sdir=$(dirname $(realpath ${BASH_SOURCE[0]}))

cp -f ${sdir}/../local.share/applications.e/*.desktop ~/.local/share/applications/e/
update-desktop-database ~/.local/share/applications/

