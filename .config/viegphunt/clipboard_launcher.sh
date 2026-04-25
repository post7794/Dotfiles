#!/usr/bin/env bash

if pidof rofi > /dev/null; then
    pkill rofi
fi

cliphist list | ~/.config/viegphunt/rofi.sh -dmenu -p "Clipboard" | cliphist decode | wl-copy
