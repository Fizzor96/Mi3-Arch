#!/usr/bin/bash

# update sys
pacman --noconfirm -Syyu

# prereq
sudo pacman --noconfirm -S --needed base-devel
sudo pacman --noconfirm -S --needed git wget sudo nano neovim ranger python python-pip perl

# installing yay
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R  dominik:users yay
cd yay
makepkg -si --noconfirm
cd ..
sudo rm -rf yay

# install dependencies
# spotify cuz i3blocks script require a spotify install 
yay --noconfirm --answerdiff None --answerclean None --removemake -Sy --needed i3exit ttf-yosemite-san-francisco-font-git ttf-fira-code ttf-font-awesome ttf-inconsolata lxappearance moka-icon-theme-git arc-gtk-theme-git capitaine-cursors picom spotify rxvt-unicode visual-studio-code-bin
# neovide??
pip install dbus-python

# copy file
cd dots
cp -r .config -t ~/
cp .bashrc .bash_profile .gtkrc-2.0 .Xresources -t ~/
# chmod +x scripts...
chmod +x ~/.config/i3blocks/scripts
cd ..

# apply changes
i3-msg restart
xrdb ~/.Xresources

# Set picom config
picom --config ~/.config/picom/picom.conf

# prevent packman/yay to update/upgrade "linux", pacmanconf addition
# pacman config file location: /etc/pacman.conf
sed -i 's/#IgnorePkg   =/IgnorePkg   = linux/g' /etc/pacman.conf

# Cleanup
yay -Yc --noconfirm

reboot now