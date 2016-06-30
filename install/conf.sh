#!/bin/bash

mkdir -p /home/harkame/.config/i3
mv ../.config/i3/config /home/$USER/.config/i3/config

mv ../.Xdefaults /home/$USER/.Xdefaults

mv ../etc/pacman.conf /etc/pacman.conf
