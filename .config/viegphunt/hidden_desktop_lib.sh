#!/usr/bin/env bash

special_name="desktop"
state_dir="$HOME/.cache/hypr"
state_file="$state_dir/show_desktop_workspace"
gesture_state_file="$state_dir/show_desktop_gesture_state"
mkdir -p "$state_dir"

active_workspace() {
    hyprctl activeworkspace -j | jq -r '.name'
}

visible_special_workspace() {
    hyprctl monitors -j | jq -r '
        [.[].specialWorkspace.name]
        | map(select(. != null and . != ""))
        | first // ""
    '
}

hidden_window_count() {
    hyprctl clients -j | jq '[.[] | select(.workspace.name == "special:desktop")] | length'
}

workspace_selector() {
    local workspace_name="$1"

    if [[ "$workspace_name" == special:* ]]; then
        printf '%s' "$workspace_name"
    elif [[ "$workspace_name" =~ ^[0-9]+$ ]]; then
        printf '%s' "$workspace_name"
    else
        printf 'name:%s' "$workspace_name"
    fi
}

disable_workspace_swipe() {
    if [ -f "$gesture_state_file" ]; then
        return 0
    fi

    printf 'disabled\n' > "$gesture_state_file"
    hyprctl keyword gesture "3, horizontal, unset" >/dev/null 2>&1
}

enable_workspace_swipe() {
    if [ ! -f "$gesture_state_file" ]; then
        return 0
    fi

    rm -f "$gesture_state_file"
    hyprctl keyword gesture "3, horizontal, workspace" >/dev/null 2>&1
}

hidden_workspace() {
    if [ ! -f "$state_file" ]; then
        return 0
    fi

    local workspace_name
    workspace_name=$(jq -r '.workspace // empty' "$state_file" 2>/dev/null)

    if [ -n "$workspace_name" ]; then
        printf '%s' "$workspace_name"
        return 0
    fi

    cat "$state_file"
}

hidden_addresses() {
    if [ ! -f "$state_file" ]; then
        return 0
    fi

    jq -r '
        if (.windows? | type) == "array"
        then .windows[]?.address
        else .addresses[]?
        end
    ' "$state_file" 2>/dev/null
}

hidden_window_floating() {
    local address="$1"

    if [ ! -f "$state_file" ]; then
        printf 'unknown'
        return 0
    fi

    jq -r --arg address "$address" '
        if (.windows? | type) == "array"
        then ([.windows[]? | select(.address == $address) | .floating] | first) // "unknown"
        else "unknown"
        end
    ' "$state_file" 2>/dev/null
}

hidden_restore_direction() {
    local previous_address="$1"
    local current_address="$2"

    if [ ! -f "$state_file" ]; then
        printf 'r'
        return 0
    fi

    local direction
    direction=$(jq -r --arg previous "$previous_address" --arg current "$current_address" '
        if (.windows? | type) != "array" then
            "r"
        else
            (.windows | map(select(.address == $previous)) | first) as $previous_window
            | (.windows | map(select(.address == $current)) | first) as $current_window
            | if ($previous_window == null or $current_window == null) then
                "r"
              else
                (($current_window.at[0] + ($current_window.size[0] / 2)) - ($previous_window.at[0] + ($previous_window.size[0] / 2))) as $dx
                | (($current_window.at[1] + ($current_window.size[1] / 2)) - ($previous_window.at[1] + ($previous_window.size[1] / 2))) as $dy
                | if (($dx | abs) >= ($dy | abs))
                  then (if $dx >= 0 then "r" else "l" end)
                  else (if $dy >= 0 then "d" else "u" end)
                  end
              end
        end
    ' "$state_file" 2>/dev/null)

    if [ -z "$direction" ] || [ "$direction" = "null" ]; then
        printf 'r'
        return 0
    fi

    printf '%s' "$direction"
}

save_hidden_state() {
    local workspace_name="$1"

    hyprctl clients -j | jq --arg workspace_name "$workspace_name" '
        [.[]
         | select(.workspace.name == $workspace_name)
         | {
             address,
             floating,
             at,
             size,
             fullscreen,
             pinned,
             focusHistoryID
           }]
        | sort_by(.floating, .at[0], .at[1], .focusHistoryID)
        | to_entries
        | {
            workspace: $workspace_name,
            windows: map(.value + {order: .key})
          }
    ' > "$state_file"
}

clear_hidden_workspace() {
    rm -f "$state_file"
}

ordered_special_addresses() {
    hyprctl clients -j | jq -r '
        [.[] | select(.workspace.name == "special:desktop")]
        | sort_by(.floating, .at[0], .at[1], .focusHistoryID)
        | .[].address
    '
}

current_window_floating() {
    local address="$1"

    hyprctl clients -j | jq -r --arg address "$address" '
        ([.[] | select(.address == $address) | .floating] | first) // false
    '
}

switch_to_workspace() {
    local workspace_name="$1"
    local selector
    selector=$(workspace_selector "$workspace_name")
    hyprctl dispatch workspace "$selector"
}

focus_window() {
    local address="$1"
    hyprctl dispatch focuswindow "address:$address" >/dev/null 2>&1
}

preselect_split() {
    local direction="$1"
    hyprctl dispatch layoutmsg preselect "$direction" >/dev/null 2>&1
}

move_addresses_to_workspace() {
    local workspace_name="$1"
    shift

    if [ "$#" -eq 0 ]; then
        return 0
    fi

    local selector
    selector=$(workspace_selector "$workspace_name")

    local address
    for address in "$@"; do
        if [ -z "$address" ]; then
            continue
        fi

        hyprctl dispatch movetoworkspacesilent "$selector,address:$address"
    done
}

replay_snapshot_to_workspace() {
    local workspace_name="$1"
    local should_switch="$2"
    shift 2

    if [ "$#" -eq 0 ]; then
        return 0
    fi

    if [ "$should_switch" = true ]; then
        switch_to_workspace "$workspace_name"
    fi

    local tiled_addresses=()
    local floating_addresses=()
    local address
    local floating_state

    for address in "$@"; do
        floating_state=$(hidden_window_floating "$address")

        if [ "$floating_state" = "unknown" ]; then
            floating_state=$(current_window_floating "$address")
        fi

        if [ "$floating_state" = "true" ]; then
            floating_addresses+=("$address")
        else
            tiled_addresses+=("$address")
        fi
    done

    local previous_tiled=""
    local direction

    for address in "${tiled_addresses[@]}"; do
        if [ -n "$previous_tiled" ]; then
            focus_window "$previous_tiled"
            direction=$(hidden_restore_direction "$previous_tiled" "$address")
            preselect_split "$direction"
        fi

        move_addresses_to_workspace "$workspace_name" "$address"
        previous_tiled="$address"
    done

    move_addresses_to_workspace "$workspace_name" "${floating_addresses[@]}"
}

move_addresses_to_workspace_batch() {
    local workspace_name="$1"
    shift

    if [ "$#" -eq 0 ]; then
        return 0
    fi

    local selector
    selector=$(workspace_selector "$workspace_name")

    local batch=""
    local address
    for address in "$@"; do
        if [ -z "$address" ]; then
            continue
        fi

        if [ -n "$batch" ]; then
            batch="$batch; "
        fi

        batch="$batch dispatch movetoworkspacesilent $selector,address:$address"
    done

    if [ -n "$batch" ]; then
        hyprctl --batch "$batch"
    fi
}

show_special_with_addresses() {
    shift

    local batch="keyword animations:enabled 0; dispatch togglespecialworkspace $special_name"
    local address

    for address in "$@"; do
        if [ -z "$address" ]; then
            continue
        fi

        batch="$batch; dispatch movetoworkspacesilent special:$special_name,address:$address"
    done

    batch="$batch; keyword animations:enabled 1"
    hyprctl --batch "$batch"
}

save_current_workspace_as_hidden() {
    local workspace_name="$1"
    local show_special_first="${2:-false}"

    save_hidden_state "$workspace_name"

    mapfile -t saved_addresses < <(hidden_addresses)

    if [ "$show_special_first" = true ]; then
        show_special_with_addresses placeholder "${saved_addresses[@]}"
        return 0
    fi

    move_addresses_to_workspace_batch "special:$special_name" "${saved_addresses[@]}"
}

restore_special_to_workspace() {
    local workspace_name="$1"
    mapfile -t current_addresses < <(ordered_special_addresses)

    if [ "${#current_addresses[@]}" -eq 0 ]; then
        clear_hidden_workspace
        return 0
    fi

    mapfile -t saved_addresses < <(hidden_addresses)

    if [ "${#saved_addresses[@]}" -eq 0 ]; then
        replay_snapshot_to_workspace "$workspace_name" true "${current_addresses[@]}"
        clear_hidden_workspace
        return 0
    fi

    local restore_addresses=()
    local saved_address
    local current_address

    for saved_address in "${saved_addresses[@]}"; do
        for current_address in "${current_addresses[@]}"; do
            if [ "$saved_address" = "$current_address" ]; then
                restore_addresses+=("$saved_address")
                break
            fi
        done
    done

    for current_address in "${current_addresses[@]}"; do
        local seen=false

        for saved_address in "${restore_addresses[@]}"; do
            if [ "$saved_address" = "$current_address" ]; then
                seen=true
                break
            fi
        done

        if [ "$seen" = false ]; then
            restore_addresses+=("$current_address")
        fi
    done

    replay_snapshot_to_workspace "$workspace_name" true "${restore_addresses[@]}"
    clear_hidden_workspace
}
