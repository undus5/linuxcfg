#!/bin/bash

bgr() { nohup "${@}" &>/dev/null & }

bgr mpv av://v4l2:/dev/video0 --profile=low-latency

