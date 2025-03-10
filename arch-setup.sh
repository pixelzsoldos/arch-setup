#!/bin/bash

echo "🚀 Arch Linux telepítő szkript indítása..."

# Ellenőrizzük, hogy root jogosultsággal fut-e
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Ezt a szkriptet root jogosultsággal kell futtatni!"
    exit 1
fi

# Ellenőrizzük, hogy archiso környezetben vagyunk-e
if [ ! -f /usr/bin/archinstall ]; then
    echo "❌ Ez a szkript csak Arch Linux telepítő környezetben futtatható!"
    exit 1
fi

# Konfiguráció létrehozása
echo "📝 Telepítési konfiguráció létrehozása..."
cat > /root/install-config.json << 'EOF'
{
    "additional_packages": [
        "neofetch",
        "tmux",
        "neovim",
        "vlc",
        "gimp",
        "inkscape",
        "obs-studio",
        "base-devel",
        "git",
        "xorg-server",
        "xorg-xinit",
        "libx11",
        "libxft",
        "libxinerama",
        "freetype2",
        "fontconfig",
        "ly"
    ],
    "audio": "pipewire",
    "bootloader": "grub-install",
    "custom-commands": [
        "systemctl enable ly.service",
        "systemctl disable lightdm.service"
    ],
    "desktop-environment": "i3",
    "gfx_driver": "All open-source",
    "hostname": "archlinux",
    "keyboard-language": "hu",
    "mirror-region": "Hungary",
    "nic": {
        "type": "NetworkManager"
    },
    "ntp": true,
    "packages": [],
    "profile": "desktop",
    "sys-encoding": "utf-8",
    "sys-language": "hu_HU",
    "timezone": "Europe/Budapest"
}
EOF

# Archinstall futtatása
echo "💿 Arch Linux telepítése..."
archinstall --config /root/install-config.json

# Várjuk meg, hogy a rendszer telepítése befejeződjön
echo "⏳ Várakozás a telepítés befejezésére..."
sleep 5

# Belépünk a telepített rendszerbe és beállítjuk a DWM-et
echo "🔧 DWM telepítése és beállítása..."
arch-chroot /mnt bash -c '
    # Yay telepítése
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay

    # AUR csomagok telepítése
    yay -S --noconfirm brave-bin ncspot

    # DWM és kapcsolódó csomagok telepítése
    cd /opt
    git clone https://git.suckless.org/dwm
    git clone https://git.suckless.org/st
    git clone https://git.suckless.org/dmenu

    # Fordítás és telepítés
    cd dwm && make clean install
    cd ../st && make clean install
    cd ../dmenu && make clean install

    # DWM hozzáadása a session listához
    mkdir -p /usr/share/xsessions
    cat > /usr/share/xsessions/dwm.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=DWM
Comment=Dynamic Window Manager
Exec=dwm
Icon=dwm
Type=XSession
EOF

    # DWM beállítása alapértelmezettként minden felhasználó számára
    echo "if [ -z \"\${DISPLAY}\" ] && [ \"\${XDG_VTNR}\" -eq 1 ]; then
    exec startx
fi" > /etc/profile.d/default-wm.sh

    echo "exec dwm" > /etc/X11/xinit/xinitrc.dwm
    chmod +x /etc/X11/xinit/xinitrc.dwm
    ln -sf /etc/X11/xinit/xinitrc.dwm /etc/X11/xinit/xinitrc
'

echo "✨ Telepítés befejezve! A rendszer újraindítása után használhatod az új Arch Linux rendszeredet!"
echo "🖥️ Az alapértelmezett ablakkezelő a DWM, de az i3 is elérhető a bejelentkezési képernyőn."
