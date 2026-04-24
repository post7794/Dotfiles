#!/usr/bin/env bash

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source "$script_dir/hidden_desktop_lib.sh"

current_ws=$(active_workspace)
visible_special=$(visible_special_workspace)
hidden_count=$(hidden_window_count)

if [ "$hidden_count" -eq 0 ]; then
    exit 0
fi

if [ "$visible_special" = "special:$special_name" ]; then
    hyprctl dispatch togglespecialworkspace "$special_name"
fi

enable_workspace_swipe
restore_special_to_workspace "$current_ws"
