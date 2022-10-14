#!/bin/sh

xrandr --output Virtual1 --primary --mode 2560x1440 --pos 0x0 --rotate normal

for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
done
unset f

# initialize X resource database (if file ~/.Xresources is present on the system)
xrdb ~/.Xresources

exec i3