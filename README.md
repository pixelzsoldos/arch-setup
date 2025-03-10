# 🚀 Arch Linux Telepítő Szkript

Ez a szkript az Arch Linux telepítését automatizálja DWM ablakkezelővel és ly bejelentkezési kezelővel.

## 📦 Telepített Csomagok

### 🛠️ Alapvető Eszközök
- Yay (AUR Helper)
- Neofetch
- Tmux
- Neovim
- VLC Media Player

### 🖥️ Ablakkezelő és Kapcsolódó Eszközök
- DWM (Dynamic Window Manager)
- ST (Simple Terminal)
- Dmenu
- ly (Display Manager)

### 🌐 Böngésző
- Brave Browser

### 🎥 Multimédia
- OBS Studio
- GIMP (Képszerkesztő)
- Inkscape (Vektorgrafikus szerkesztő)

### 🎵 Zene
- ncspot (Terminal-alapú Spotify kliens)

## 💻 Használat

1. Indítsd el az Arch Linux telepítő ISO-t

2. Klónozd le ezt a repót:
```bash
pacman -Sy git
git clone https://github.com/FELHASZNÁLÓNÉV/arch-setup.git
cd arch-setup
```

3. Futtasd a telepítő szkriptet root jogosultsággal:
```bash
chmod +x arch-setup.sh
./arch-setup.sh
```

## ⚠️ Megjegyzések
- A szkript csak Arch Linux telepítő környezetben futtatható
- Root jogosultságok szükségesek
- A telepítés automatikusan beállítja a DWM-et alapértelmezett ablakkezelőként
- A bejelentkezéshez az ly display manager lesz használva
- Az i3 profil is telepítve lesz alternatív opcióként

## 🤝 Közreműködés
Ha hibát találsz vagy fejlesztési javaslatod van, nyugodtan nyiss egy issue-t vagy küldj egy pull requestet!

## 📜 Licensz
MIT 