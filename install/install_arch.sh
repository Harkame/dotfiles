#!/bin/bash

umount -R /mnt
wipefs -af /dev/sda

read -p "[cleanup finished] Press enter"

parted -a optimal /dev/sda mklabel gpt mkpart primary linux-swap 0% 4096MB
parted -a optimal /dev/sda mkpart primary 4096MB 100%

read -p "[parted finished] Press enter"

mkswap /dev/sda1
swapon /dev/sda1

#mkfs.ext4 -L "Boot" /dev/sda1
mkfs.btrfs -L "Arch" -f -n 65536 /dev/sda2

read -p "[mkswap + mkfs finished] Press enter"

mount /dev/sda2 /mnt

pacstrap /mnt base base-devel networkmanager grub btrfs-progs mkinitcpio linux

read -p "[pacstrap finished] Press enter"

arch-chroot /mnt

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

pacman -Syu

read -p "[pacman] Press enter"

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --utc

read -p "[hwclock finished] Press enter"

echo "Skadi" >> /etc/hostname

mkdir /boot/grub/
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=esp --boot-directory=/mnt/boot --bootloader-id=GRUB /dev/sda

read -p "[grub-install] Press enter"

mkinitcpio -p linux

read -p "[mkinitcpio finished] Press enter"

useradd -m -g users -G wheel -s /bin/bash harkame

exit

read -p "[] Press enter"

umount -R /mnt

read -p "[] Press enter"

reboot