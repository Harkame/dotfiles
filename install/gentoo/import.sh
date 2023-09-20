#!/bin/zsh

mkdir -p ../dotfiles/etc/;

mkdir -p ../dotfiles/.local/share/fonts/;

cp -r -f ~/.local/share/fonts ../dotfiles/.local/share/fonts;

cp -r -f ~/.xinitrc ../dotfiles/;

cp -r -f ~/.config/i3 ../dotfiles/.config/;

cp -r -f ~/.config/i3blocks ../dotfiles/.config/;

cp -r -f ~/.config/neofetch ../dotfiles/.config/;

cp -r -f ~/.oh-my-zsh/ ../dotfiles/;

cp -r -f ~/ascii_script/ ../dotfiles/;

cp -f ~/.Xdefaults ../dotfiles/;

cp -f ~/.zshrc ../dotfiles/;