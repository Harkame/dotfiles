#!/bin/bash

pacman -Syu yay

yay -Syyu --noconfirm '
	xorg-server
	xorg-xini
	xorg-xmessage
	xorg-apps
	xorg-xrandr
	rxvt-unicode
	i3
	i3-gaps
	i3blocks
	vivaldi
	flashplugin
	sunflower
	lxtask
	ntfs-3g
	boost-libs
	libldap
	mplayer
	feh
	gksu
	rtmpdump
	neofetch
	lxappearance
	alsa-utils
	zsh
	gdb
	btrfs-progs
	oh-my-zsh-git
	lm_sensors
	ttf-ms-fonts
	pycharm-comminuty-edition
	neofetch'

echo "exec i3" >> .xinitrc

ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

chsh -s /bin/zsh

hwclock --hctosys

rmmod pcspkr

git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global user.name Harkame
git config --global user.email louisr.daviaud@gmail.com