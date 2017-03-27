#!/bin/zsh

cp -r -f /home/$USER/.config/ ../dotfiles/.config;

cp -f /home/$USER/.Xdefaults ../dotfiles/.Xdefaults;

cp -f /home/$USER/.zshrc ../dotfiles/.zshrc;

cp -f /home/$USER/.bashrc ../dotfiles/.bashrc;

cp -f /etc/pacman.conf ../dotfiles/etc/pacman.conf;

find ../dotfiles/ -type f -print0 | xargs 0 sed -r "/s/USER/$USER/g"
