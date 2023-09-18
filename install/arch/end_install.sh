#!/bin/bash

sudo pacman -Syu yay --noconfirm

yay -Sy --noconfirm - < package.txt

sudo rm /usr/lib/python*/EXTERNALLY-MANAGED

sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

chsh -s /bin/zsh

hwclock --hctosys

sudo rmmod pcspkr

git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global user.name Harkame
git config --global user.email louisr.daviaud@gmail.com