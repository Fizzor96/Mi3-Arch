#!/usr/bin/bash

# Update system
pacman --noconfirm -Syyu

# Ranking best mirrors for Arch
pacman -S pacman-contrib --noconfirm
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Prerequisites
sudo pacman --noconfirm -S --needed base-devel
sudo pacman --noconfirm -S --needed git wget sudo nano ranger python python-pip perl

# Install yay
yay_install_path=/usr/bin/yay
if [ -f "$yay_install_path" ]
then
    echo "$FILE exists."
else
    sudo git clone https://aur.archlinux.org/yay.git
    sudo chown -R  dominik:users yay
    cd yay
    makepkg -si --noconfirm
    cd ..
    sudo rm -rf yay
fi

# Install required packages
PKGS=(
'lightdm-webkit2-greeter'
'geany'
'geany-themes'
'feh'
'i3exit'
'i3lock' 
'ntfs-3g'
'ttf-yosemite-san-francisco-font-git'
'ttf-fira-code ttf-font-awesome'
'ttf-inconsolata'
'lxappearance'
'moka-icon-theme-git'
'arc-gtk-theme-git'
'capitaine-cursors'
'i3blocks-contrib'
'acpi'
'xorg-xset'
'alsa-utils'
'iwgtk'
'spotify-launcher'
'rxvt-unicode'
'dbus'
'picom'
'visual-studio-code-bin'
'chromium'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed --answerdiff None --answerclean None
done

# for i3blocks-spotify
pip install dbus-python

# Copy configs
cd dots
cp -r .config -t ~/
cp .bashrc .wallpaper.png .bash_profile .gtkrc-2.0 .Xresources -t ~/
chmod +x ~/.config/i3blocks/scripts
cd ..

# Copy lightdm theme
git clone https://github.com/dimaglushkov/lightdm-webkit2-theme-minimal.git
sudo cp -r lightdm-webkit2-theme-minimal -t /usr/share/lightdm-webkit/themes
cd /usr/share/lightdm-webkit/themes
sudo mv lightdm-webkit2-theme-minimal minimal

# Prevent packman/yay to update/upgrade "linux", pacmanconf addition
# pacman config file location: /etc/pacman.conf
sudo sed -i 's/#IgnorePkg   =/IgnorePkg   = linux/g' /etc/pacman.conf

# for brightnesscontroll
# sudo chmod a+rw /sys/class/backlight/intel_backlight/brightness
sudo usermod -aG video $USER

# apply changes
i3-msg restart
xrdb ~/.Xresources

# Cleanup
yay -Yc --noconfirm