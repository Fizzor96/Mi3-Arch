#!/usr/bin/bash

# check internet connection or connect wireless

# install i3-gaps thru archinstall

# update sys
yay --noconfirm --answerdiff None --answerclean None --removemake -Syy
yay --noconfirm --answerdiff None --answerclean None --removemake -Syu

# prereq
sudo pacman --noconfirm -S --needed base-devel
sudo pacman --noconfirm -S git wget sudo nano neovim ranger python python-pip

# installing yay
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R  dominik:users yay
cd yay
makepkg -si --noconfirm
cd ..
sudo rm -rf yay

# install dependencies
yay --noconfirm --answerdiff None --answerclean None --removemake -Sy i3exit ttf-yosemite-san-francisco-font-git ttf-fira-code ttf-font-awesome ttf-inconsolata lxappearance moka-icon-theme-git arc-gtk-theme-git capitaine-cursors picom spotify
# neovide??
pip install dbus-python

# copy file
cd dots
cp -r .config -t ~/
cp .bashrc .bash_profile .gtkrc-2.0 .Xresources
# chmod +x scripts...
chmod +x ~/.config/i3blocks/scripts
cd ..

# Set picom config
picom --config ~/.config/picom/picom.conf

# Cleanup
yay -Yc --noconfirm

reboot now