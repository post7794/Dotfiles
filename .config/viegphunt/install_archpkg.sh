#!/usr/bin/env bash

pacman_packages=(
    # Hyprland & Wayland Environment
    hyprland hyprlock awww grim slurp swaync waybar rofi rofi-emoji yad hyprshot hypridle xdg-desktop-portal-hyprland xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk

    # System
    brightnessctl network-manager-applet bluez bluez-utils blueman pipewire wireplumber pavucontrol playerctl

    # System Utilities and Media
    ghostty nemo gvfs loupe celluloid gnome-text-editor evince obs-studio ffmpeg cava

    # Shell & Terminal Tools
    zsh tmux neovim fzf zoxide eza bat jq stow ripgrep fd openssh man-db make curl wget unzip btop fastfetch cmatrix cowsay lazygit

    # Programming Languages (for nvim LSP & formatters)
    python python-pip nodejs npm go

    # Qt & Display Manager Support
    sddm qt5ct qt6ct qt5-wayland qt6-wayland

    # Input Method
    fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-bamboo

    # Fonts
    ttf-jetbrains-mono-nerd noto-fonts

    # Theming
    nwg-look adw-gtk-theme kvantum-qt5

    # Image processing (for wallpaper_effects.sh)
    libvips libheif openslide poppler-glib

    # Misc
    cliphist gnome-characters keepass
)

aur_packages=(
    # Hyprland & Wayland Environment
    wlogout

    # Shell & Terminal
    oh-my-posh-bin

    # Communication
    spotify zen-browser-bin

    # Code Editors and IDEs
    visual-studio-code-bin

    # Fonts & Theming
    fonts-apple sddm-astronaut-theme apple_cursor whitesur-icon-theme tint

    # Fun
    pokemon-colorscripts-git pipes.sh cbonsai

    # Terminal tools
    lazydocker-bin
)

sudo pacman -S --noconfirm --needed "${pacman_packages[@]}"
yay -S --noconfirm --needed "${aur_packages[@]}"
