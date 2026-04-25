#!/usr/bin/env bash

SCHEME="prefer-dark"
THEME="adw-gtk3-dark"
ICONS="WhiteSur-dark"
CURSOR="macOS"
UI_FONT="Segoe UI Variable Static Text 12"
MONO_FONT="JetBrainsMono Nerd Font 12"

SCHEMA="gsettings set org.gnome.desktop.interface"

apply_themes() {
    ${SCHEMA} color-scheme "$SCHEME" 2>/dev/null || true
    ${SCHEMA} gtk-theme "$THEME" 2>/dev/null || true
    ${SCHEMA} icon-theme "$ICONS" 2>/dev/null || true
    ${SCHEMA} cursor-theme "$CURSOR" 2>/dev/null || true
    ${SCHEMA} font-name "$UI_FONT" 2>/dev/null || true
    ${SCHEMA} monospace-font-name "$MONO_FONT" 2>/dev/null || true
}

# Also set Nemo default terminal
gsettings set org.cinnamon.desktop.default-applications.terminal exec ghostty 2>/dev/null || true

apply_themes
