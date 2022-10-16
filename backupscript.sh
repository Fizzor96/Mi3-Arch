#!/bin/bash
echo "Backup starting..."
echo "Creating folder \"backup\" under home"
mkdir ~/backup &>/dev/null
mkdir ~/backup/config &>/dev/null
echo "Copying configs"
cp .bash_history -t ~/backup
mv ~/backup/.bash_history ~/backup/bash_history
cp ~/.bashrc -t ~/backup
cp ~/.bash_profile -t ~/backup
cp ~/.Xresources -t ~/backup
cp ~/.gtkrc-2.0 -t ~/backup
cp ~/.wallpaper.png -t ~/backup
cp -r ~/.config/i3 -t ~/backup/config
cp -r ~/.config/i3blocks -t ~/backup/config
cp -r ~/.config/gtk-2.0 -t ~/backup/config
cp -r ~/.config/gtk-3.0 -t ~/backup/config
echo "Backup done!"