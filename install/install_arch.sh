#!/bin/bash

umount -R /mnt
wipefs -af /dev/sda

parted -a optimal /dev/sda mklabel gpt mkpart primary linux-swap 0% 4096MB
parted -a optimal /dev/sda mkpart primary 4096MB 100%

mkswap /dev/sda1
swapon /dev/sda1

#mkfs.ext4 -L "Boot" /dev/sda1
mkfs.btrfs -L "Arch" -f -n 65536 /dev/sda2

mount /dev/sda2 /mnt

pacstrap /mnt base base-devel networkmanager grub btrfs-progs mkinitcpio linux

genfstab -p -U /mnt >> /mnt/etc/fstab

systemctl enable NetworkManager.service

echo "KEYMAP=fr-latin9" >> /etc/vconsole.conf
echo "FONT=eurlatgr" >> /etc/vconsole.conf

echo "" >> /etc/vconsole.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/vconsole.conf
echo "Server = http://repo.archlinux.fr/$arch" >> /etc/vconsole.conf
echo "" >> /etc/vconsole.conf
echo "[blackarch]" >> /etc/vconsole.conf
echo "SigLevel = Never" >> /etc/vconsole.conf
echo "Server = http://blackarch.org/blackarch/$repo/os/$arch" >> /etc/vconsole.conf

pacman -Syu

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --utc

echo "Skadi" >> /etc/hostname

mkdir /boot/grub/
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=esp --boot-directory=/mnt/boot --bootloader-id=GRUB /dev/sda

mkinitcpio -p linux

useradd -m -g users -G wheel -s /bin/bash harkame

umount -R /mnt

reboot