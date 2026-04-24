#!/usr/bin/env bash

if pidof rofi > /dev/null; then
    pkill rofi
fi

# Get current connection
current=$(nmcli -t -f active,ssid dev wifi | grep '^yes:' | cut -d: -f2)

# Scan and list WiFi networks
networks=$(nmcli -t -f ssid,signal,security dev wifi list --rescan yes | sort -t: -k2 -rn | awk -F: '!seen[$1]++' | while IFS=: read -r ssid signal security; do
    [ -z "$ssid" ] && continue
    if [ "$ssid" = "$ssid" ] && [ "$ssid" = "$current" ]; then
        echo "$ssid  (*)  ${signal}%  $security"
    else
        echo "$ssid  ${signal}%  $security"
    fi
done)

[ -z "$networks" ] && notify-send "WiFi" "No networks found" && exit 1

selected=$(echo "$networks" | rofi -dmenu -i -p "WiFi" -theme ~/.config/rofi/config.rasi | awk '{print $1}')

[ -z "$selected" ] && exit 0

# Try to connect
nmcli dev wifi connect "$selected" 2>/dev/null || nmcli dev wifi connect "$selected" --ask
