
{
genfstab -p -U /mnt >> /mnt/etc/fstab

systemctl enable NetworkManager.service

read -p "[genfstab + systemctl finished] Press enter"

echo "KEYMAP=fr-latin9" >> /etc/vconsole.conf
echo "FONT=eurlatgr" >> /etc/vconsole.conf

read -p "[vconsole.conf finished] Press enter"

echo "" >> /etc/pacman.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
echo "" >> /etc/pacman.conf
echo "[blackarch]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://blackarch.org/blackarch/$repo/os/$arch" >> /etc/pacman.conf

read -p "[vconsole.conf finished] Press enter"
} | arch-chroot /mnt