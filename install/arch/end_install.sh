#!/bin/bash

echo -e "mypassword" | sudo pacman -Syu yay --noconfirm

yay -Sy --noconfirm - < package.txt

sudo rm /usr/lib/python*/EXTERNALLY-MANAGED

sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

echo -e "mypassword" | chsh -s /bin/zsh

echo -e "mypassword" | sudo hwclock --hctosys

sudo rmmod pcspkr

git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global user.name Harkame
git config --global user.email louisr.daviaud@gmail.com

./export.sh

git clone https://github.com/vivien/i3blocks-contrib ~/workspace/
ln -s ~workspace/i3blocks-contib/volume/volume ~/scripts/volume
ln -s ~workspace/i3blocks-contrib/battery/battery ~/scripts/battery

reboot
