#!/usr/bin/env bash

errf() { printf "${1}" >&2 && exit 1; }

command -v magick &>/dev/null || errf "command not found: magick\n"

img=${1}

[[ -f "${img}" ]] || errf "file not found: ${img}"

filename=$(basename "${img}")
basename="${filename%.*}"
ext="${filename##*.}"
target_ext="webp"
target_width=960

if [[ -n $2 ]]; then
    output_name="${2%.*}.${target_ext}"
else
    # output_name="${basename}.${target_ext}"
    output_name="poster.${target_ext}"
fi

# img_width=$(identify -format "%w" "${img}")
# if ((img_width > target_width)); then
#     magick "${img}" -scale ${target_width}x "$output_name"
# else
#     magick "${img}" "$output_name"
# fi
magick "${img}" -scale ${target_width}x "$output_name"

