#!/bin/bash

bgr() { nohup "${@}" &>/dev/null & }

MANGOHUD_CONFIG="gpu_temp,cpu_temp,frametime=0"
bgr mangohud vkcube

