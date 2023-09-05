
pacman -Syu git yay

echo "exec i3" >> .xinitrc

ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

chsh -s /bin/zsh

hwclock --hctosys

rmmod pcspkr

nano /etc/sudoers
	+harkame ALL=(ALL) ALL

chown -R harkame /home/harkame

git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global user.name Harkame
git config --global user.email ~

TODO : TEST https://www.reddit.com/r/archlinux/comments/3338jv/wireless_not_connecting_at_all_tried_everything/
TODO : TEST https://askubuntu.com/questions/309461/how-to-disable-ipv6-permanently
