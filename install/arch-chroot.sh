arch-chroot /mnt

systemctl enable NetworkManager.service

echo "KEYMAP=fr-latin9" >> /etc/vconsole.conf
echo "FONT=lat9w-16" >> /etc/vconsole.conf

sed -r /etc/locale.gen s/#fr_FR.UTF-8/fr_FR.UTF-8/g

echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf

echo "" >> /etc/pacman.conf

echo "[blackarch]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://blackarch.org/blackarch/$repo/os/$arch" >> /etc/pacman.conf

echo "LANG=fr_FR.UTF-8" >> /etc/locale.conf
echo "LC_COLLATE=C" >> /etc/locale.conf

export LANG=fr_FR.UTF-8
locale-gen

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --utc

echo "Skadi" >> /etc/hostname

grub-mkconfig -o /boot/grub/grub.cfg
grub-install --no-floppy --recheck /dev/sda

mkinitcpio -p linux
