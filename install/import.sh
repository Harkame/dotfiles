#!/bin/zsh

mkdir -p ../dotfiles/etc/;

cp -r -f /home/$USER/.config/ ../dotfiles/;

cp -r -f /home/$USER/.oh-my-zsh/ ../dotfiles/;

cp -r -f /home/$USER/ascii_script/ ../dotfiles/;

cp -f /home/$USER/.Xdefaults ../dotfiles/;

cp -f /home/$USER/.zshrc ../dotfiles/;

cp -f /etc/pacman.conf ../dotfiles/etc/pacman.conf;

curl "https://api.github.com/Harkame?tab=repositories" |
grep -e 'git_url*' |
cut -d \" -f 4 |
xargs -L1 git clone;
