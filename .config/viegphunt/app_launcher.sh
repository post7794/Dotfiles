#!/usr/bin/env bash

if [ "$1" = "--zh" ]; then
    tmpfile=$(mktemp)
    ghostty -e ~/.config/viegphunt/zh_launcher.sh > "$tmpfile" 2>/dev/null
    selected=$(cat "$tmpfile")
    rm -f "$tmpfile"
    [ -z "$selected" ] && exit 0
    gtk-launch "$selected" &
else
    if pidof rofi > /dev/null; then
        pkill rofi
    fi
    rofi -show drun
fi
