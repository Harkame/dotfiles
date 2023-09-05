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

arch-chroot /mnt bash -c '
	genfstab -p -U /mnt >> /mnt/etc/fstab;

	pacman -Sy networkmanager --noconfirm;
	systemctl enable NetworkManager.service;

	echo "KEYMAP=fr-latin9" >> /etc/vconsole.conf;
	echo "FONT=eurlatgr" >> /etc/vconsole.conf;

	echo "" >> /etc/pacman.conf;
	echo "[archlinuxfr]" >> /etc/pacman.conf;
	echo "SigLevel = Never" >> /etc/pacman.conf;
	echo "Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf;
	echo "" >> /etc/pacman.conf;
	echo "[blackarch]" >> /etc/pacman.conf;
	echo "SigLevel = Never" >> /etc/pacman.conf;
	echo "Server = http://blackarch.org/blackarch/\$repo/os/\$arch" >> /etc/pacman.conf;

	pacman -Syu;

	ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime;
	hwclock --systohc --utc;

	echo "Skadi" >> /etc/hostname;

	mkdir /boot/grub/
	grub-mkconfig -o /boot/grub/grub.cfg
	grub-install --target=x86_64-efi --efi-directory=esp --boot-directory=/mnt/boot --bootloader-id=GRUB /dev/sda;

	mkinitcpio -p linux;

	echo -e "mypassword\nmypassword" | passwd root;

	useradd -m -g users -G wheel -s /bin/bash harkame;
	echo -e "mypassword\nmypassword" | passwd harkame;
'

umount -R /mnt

read -p "[] Press enter"

reboot