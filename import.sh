#!/bin/zsh

mkdir .config

cp -Rf ~/.config/i3 .config
cp -Rf ~/.config/i3blocks .config
cp -Rf ~/.config/fastfetch .config
cp -Rf ~/.oh-my-zsh/ .
cp -Rf ~/ascii/ .

cp -f ~/.Xdefaults .
cp -f ~/.xinitrc .xinitrc
cp -f ~/.zshrc .