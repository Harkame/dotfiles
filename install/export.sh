#!/bin/zsh

cp -r -f ../dotfiles/.config /home/$USER/.config;

cp -f ../dotfiles/.zshrc /home/$USER/.zshrc;

cp -f ../dotfiles/.bashrc /home/$USER/.bashrc;

cp -f ../dotfiles/.Xdefaults /home/$USER/.Xdefaults;

cp -f ../dotfiles/etc/pacman.conf /etc/pacman.conf;

find ../dotfiles/ -type f -print0 | xargs 0 sed -r "/s/$USER/USER/g"
