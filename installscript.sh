#!/usr/bin/bash

# update sys
pacman --noconfirm -Syyu

# prereq
sudo pacman --noconfirm -S --needed base-devel
sudo pacman --noconfirm -S --needed git wget sudo nano ranger python python-pip perl

# installing yay
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


# install dependencies
# spotify cuz i3blocks script require a spotify install 
yay --noconfirm --answerdiff None --answerclean None --removemake -Sy --needed feh i3exit i3lock ntfs-3g ttf-yosemite-san-francisco-font-git ttf-fira-code ttf-font-awesome ttf-inconsolata lxappearance moka-icon-theme-git arc-gtk-theme-git capitaine-cursors i3blocks-contrib acpi xorg-xset alsa-utils network-manager-applet spotify-launcher rxvt-unicode visual-studio-code-bin dbus picom

# pip install dbus-python

# copy configs
cd dots
cp -r .config -t ~/
cp .bashrc .wallpaper.png .bash_profile .gtkrc-2.0 .Xresources -t ~/
chmod +x ~/.config/i3blocks/scripts
cd ..

# apply changes
i3-msg restart
xrdb ~/.Xresources

# prevent packman/yay to update/upgrade "linux", pacmanconf addition
# pacman config file location: /etc/pacman.conf
sudo sed -i 's/#IgnorePkg   =/IgnorePkg   = linux/g' /etc/pacman.conf

# brightnesscontrolls 
# sudo chmod a+rw /sys/class/backlight/intel_backlight/brightness
sudo usermod -aG video $USER

# network
# systemctl start NetworkManager
# systemctl enable NetworkManager

# lightdm resolution
# sudo cp lightdmxrandr.sh -t /etc/lightdm/
# chmod a+xr /etc/lightdm/lightdmxrandr.sh
# sudo sed -i 's/# display-setup-script = Script to run when starting a greeter session (runs as root)/display-setup-script = /etc/lightdm/lightdmxrandr.sh/g' /etc/lightdm/lightdm.conf

# Cleanup
yay -Yc --noconfirm

#sudo reboot now
