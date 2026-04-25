#!/usr/bin/env bash

# Launch rofi with XWayland/xcb backend for fcitx5 IME support
# rofi 2.0.0 lacks Wayland text-input-v3 protocol, so IM only works via xcb
export WAYLAND_DISPLAY=""
export DISPLAY=:1
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
exec rofi "$@"
