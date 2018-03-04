#!/bin/zsh

mkdir -p ../dotfiles/etc/;

cp -r -f /home/$USER/.config/ ../dotfiles/;

cp -r -f /home/$USER/.oh-my-zsh/ ../dotfiles/;

cp -r -f /home/$USER/ascii_script/ ../dotfiles/;

cp -f /home/$USER/.Xdefaults ../dotfiles/;

cp -f /home/$USER/.zshrc ../dotfiles/;

cp -f /etc/pacman.conf ../dotfiles/etc/pacman.conf;
