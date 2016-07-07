#!/bin/bash

mkdir -p /home/harkame/.config/i3
mv -f ../.config/i3/config /home/$USER/.config/i3/

mv -f ../.Xdefaults /home/$USER/

mv -f ../etc/pacman.conf /etc/
