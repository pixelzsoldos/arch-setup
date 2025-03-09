#!/bin/bash

echo "🚀 Arch Linux telepítő szkript indítása..."

# Yay (AUR helper) telepítése
if ! command -v yay &> /dev/null; then
    echo "📦 Yay telepítése..."
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

# Alapvető csomagok telepítése
echo "🔧 Alapvető csomagok telepítése..."
sudo pacman -S --needed neofetch tmux neovim vlc

# AUR csomagok telepítése
echo "📥 AUR csomagok telepítése..."
yay -S --needed brave-bin

# DWM és kapcsolódó csomagok
echo "🖥️ DWM és kapcsolódó csomagok telepítése..."
sudo pacman -S --needed base-devel libx11 libxft libxinerama freetype2 fontconfig
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu

# DWM fordítása és telepítése
cd dwm
sudo make clean install
cd ..

# ST fordítása és telepítése
cd st
sudo make clean install
cd ..

# Dmenu fordítása és telepítése
cd dmenu
sudo make clean install
cd ..

# OBS Studio telepítése
echo "🎥 OBS Studio telepítése..."
sudo pacman -S --needed obs-studio

echo "✨ Telepítés befejezve! Használd a 'startx' parancsot a DWM indításához."
