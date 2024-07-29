#!/bin/zsh

mkdir -p ../../dotfiles

cp -Rf ~/.config/i3 ../../dotfiles/.config/
cp -Rf ~/.config/i3blocks ../../dotfiles/.config/
cp -Rf ~/.config/fastfetch ../../dotfiles/.config/
cp -Rf ~/.oh-my-zsh/ ../../dotfiles/
cp -Rf ~/ascii/ ../../dotfiles/

cp -f ~/.Xdefaults ../../dotfiles/
cp -Rf ~/.xinitrc ../../dotfiles/.xinitrc
cp -f ~/.zshrc ../../dotfiles/