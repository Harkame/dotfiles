#!/bin/zsh

mkdir -p ../dotfiles/etc/;

mkdir -p ../dotfiles/.local/share/fonts/;

cp -r -f /home/$USER/.local/share/fonts ../dotfiles/.local/share/fonts;

cp -r -f /home/$USER/.xinitrc ../dotfiles/;

cp -r -f /home/$USER/.config/i3 ../dotfiles/.config/;

cp -r -f /home/$USER/.config/i3blocks ../dotfiles/.config/;

cp -r -f /home/$USER/.config/neofetch ../dotfiles/.config/;

cp -r -f /home/$USER/.oh-my-zsh/ ../dotfiles/;

cp -r -f /home/$USER/ascii_script/ ../dotfiles/;

cp -f /home/$USER/.Xdefaults ../dotfiles/;

cp -f /home/$USER/.zshrc ../dotfiles/;

cp -f /etc/pacman.conf ../dotfiles/etc/pacman.conf;
