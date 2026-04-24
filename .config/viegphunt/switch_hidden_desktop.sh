#!/usr/bin/env bash

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source "$script_dir/hidden_desktop_lib.sh"

current_ws=$(active_workspace)
visible_special=$(visible_special_workspace)
hidden_count=$(hidden_window_count)
old_ws=$(hidden_workspace)

if [ "$visible_special" = "special:$special_name" ]; then
    hyprctl dispatch togglespecialworkspace "$special_name"
    enable_workspace_swipe
fi

if [ "$hidden_count" -eq 0 ]; then
    save_current_workspace_as_hidden "$current_ws"
    exit 0
fi

if [ -z "$old_ws" ]; then
    old_ws="$current_ws"
fi

if [ "$old_ws" = "$current_ws" ]; then
    exit 0
fi

restore_special_to_workspace "$old_ws"
save_current_workspace_as_hidden "$current_ws"
