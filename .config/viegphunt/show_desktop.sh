#!/usr/bin/env bash

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source "$script_dir/hidden_desktop_lib.sh"

current_ws=$(active_workspace)
hidden_count=$(hidden_window_count)
visible_special=$(visible_special_workspace)

if [ "$hidden_count" -eq 0 ]; then
    disable_workspace_swipe

    if [ "$visible_special" = "special:$special_name" ]; then
        save_current_workspace_as_hidden "$current_ws"
    else
        save_current_workspace_as_hidden "$current_ws" true
    fi
    exit 0
fi

if [ "$visible_special" = "special:$special_name" ]; then
    hyprctl dispatch togglespecialworkspace "$special_name"
    enable_workspace_swipe
    exit 0
fi

disable_workspace_swipe
hyprctl dispatch togglespecialworkspace "$special_name"
