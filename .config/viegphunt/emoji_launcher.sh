#!/usr/bin/env bash

if pidof rofi > /dev/null; then
    pkill rofi
fi

~/.config/viegphunt/rofi.sh -show emoji
