#!/bin/bash

umount -R /mnt
wipefs -af /dev/sda

parted /dev/sda mklabel gpt
parted -a optimal /dev/sda mkpart primary fat32 0% 1024MB
parted -a optimal /dev/sda mkpart primary linux-swap 1024MB 5096MB
parted -a optimal /dev/sda mkpart primary btrfs 5096MB 100%

echo -e "set 1 bios_grub on" | parted /dev/sda

mkfs.fat -F 32 /dev/sda1

mkswap /dev/sda2
swapon /dev/sda2

mkfs.btrfs -L "Arch" -f -n 65536 /dev/sda3

mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot

pacstrap /mnt base base-devel grub btrfs-progs mkinitcpio linux linux-firmware efibootmgr nano

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt bash -c '
	pacman -Sy networkmanager --noconfirm
	systemctl enable NetworkManager.service

	echo "KEYMAP=fr" >> /etc/vconsole.conf
	echo "FONT=eurlatgr" >> /etc/vconsole.conf

	echo "" >> /etc/pacman.conf
	echo "[blackarch]" >> /etc/pacman.conf
	echo "SigLevel = Never" >> /etc/pacman.conf
	echo "Server = http://blackarch.org/blackarch/\$repo/os/\$arch" >> /etc/pacman.conf

	pacman -Syu

	ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
	hwclock --systohc
	locale-gen

	echo "Skadi" >> /etc/hostname

	mkdir /boot/grub
	grub-mkconfig -o /boot/grub/grub.cfg
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck

	mkinitcpio -p linux

	echo -e "mypassword\nmypassword" | passwd root

	useradd -m -g users -G wheel -s /bin/bash harkame
	echo -e "mypassword\nmypassword" | passwd harkame
	sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /etc/sudoers
	chown -R harkame /home/harkame
'

umount -R /mnt

reboot