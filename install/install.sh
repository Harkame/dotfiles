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

pacstrap /mnt base base-devel grub btrfs-progs mkinitcpio linux

chmod +x chroot.sh
arch-chroot /mnt ./chroot.sh

umount -R /mnt

read -p "[] Press enter"

reboot