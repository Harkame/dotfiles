#!/bin/zsh

mkdir -p /home/$USER/.local/share/fonts/;

cp -r -f ../dotfiles/.local/share/fonts /home/$USER/.local/share/fonts;

fc-cache -fv;

cp -r -f ../dotfiles/.xinitrc /home/$USER/;

cp -r -f  ../dotfiles/.config /home/$USER/;

cp -r -f  ../dotfiles/.oh-my-zsh /home/$USER/;

cp -r -f  ../dotfiles/ascii_script /home/$USER/;

cp -r -f  ../dotfiles/.Xdefaults /home/$USER/;

cp -r -f  ../dotfiles/.zshrc /home/$USER/;

cp -r -f  ../dotfiles/etc/pacman.conf /etc/;
