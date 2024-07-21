#!/bin/zsh

mkdir -p /home/$USER/.local/share/fonts/;

cp -r -f ../../dotfiles/.local/share/fonts ~/.local/share/fonts;

fc-cache -fv;

cp -r -f ../../dotfiles/.xinitrc ~/;

cp -r -f  ../../dotfiles/.config ~/;

cp -r -f  ../../dotfiles/.oh-my-zsh ~/;

cp -r -f  ../../dotfiles/ascii_script ~/;

cp -r -f  ../../dotfiles/.Xdefaults ~/;

cp -r -f  ../../dotfiles/.zshrc ~/;