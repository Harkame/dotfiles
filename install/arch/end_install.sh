#!/bin/bash

sudo pacman -Syu yay --noconfirm

yay -Sy --noconfirm - < package.txt

sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

chsh -s /bin/zsh

hwclock --hctosys

rmmod pcspkr

git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global user.name Harkame
git config --global user.email louisr.daviaud@gmail.com