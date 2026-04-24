#!/usr/bin/env bash

current_wallpaper_path=$(awww query | grep -oP 'image: \K.*' | head -n 1)
destination_wallpaper_dir="$HOME/.cache/awww"
mkdir -p "$destination_wallpaper_dir"

rm -f "$destination_wallpaper_dir/normal.png"
vipsthumbnail "$current_wallpaper_path" -o "$destination_wallpaper_dir/normal.png"
