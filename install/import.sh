#!/bin/zsh

mkdir -p ../dotfiles/etc/;

cp -r -f /home/$USER/.xinitrc ../dotfiles/;

cp -r -f /home/$USER/.config/i3 ../dotfiles/.config/i3;

cp -r -f /home/$USER/.config/i3blocks ../dotfiles/.config/i3blocks;

cp -r -f /home/$USER/.config/neofetch ../dotfiles/.config/neofetch;

cp -r -f /home/$USER/.oh-my-zsh/ ../dotfiles/;

cp -r -f /home/$USER/ascii_script/ ../dotfiles/;

cp -f /home/$USER/.Xdefaults ../dotfiles/;

cp -f /home/$USER/.zshrc ../dotfiles/;

cp -f /etc/pacman.conf ../dotfiles/etc/pacman.conf;
