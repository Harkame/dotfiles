#!/bin/bash

sfdisk --delete /dev/sda
wipefs -a /dev/sda

if [ -d "/sys/firmware/efi" ]
then
	parted /dev/sda mklabel gpt
else
	parted /dev/sda mklabel msdos
fi

parted -a optimal /dev/sda mkpart primary fat32 0% 1024MB
parted -a optimal /dev/sda mkpart primary linux-swap 1024MB 5096MB
parted -a optimal /dev/sda mkpart primary btrfs 5096MB 100%

if [ -d "/sys/firmware/efi" ]
then
	echo -e "set 1 esp on" | parted /dev/sda
else
	echo -e "set 1 bios_grub on" | parted /dev/sda
fi

mkfs.fat -F 32 /dev/sda1

mkswap /dev/sda2
swapon /dev/sda2

mkfs.btrfs -L "Gentoo" -f -n 65536 /dev/sda3

mount --mkdir /dev/sda3 /mnt/gentoo

if [ -d "/sys/firmware/efi" ]
then
  mount --mkdir /dev/sda1 /mnt/gentoo/efi
else
  mount --mkdir /dev/sda1 /mnt/gentoo/boot
fi

cd /mnt/gentoo

wget https://distfiles.gentoo.org/releases/amd64/autobuilds/20230917T164636Z/stage3-amd64-openrc-20230917T164636Z.tar.xz
tar xpf stage*

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

mkdir /mnt/gentoo/etc
cp /etc/resolv.conf etc/

chroot . bash -c '
  emerge-webrsync
  emerge -DN @world

  echo -e "mypassword\nmypassword" | passwd root
  useradd -m -g users -G wheel -s /bin/bash harkame
  echo -e "mypassword\nmypassword" | passwd harkame
  sed -i "s/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers
  chown -R harkame /home/harkame

  sed -i "s/^keymap=\"us\"/keymap=\"fr\"/g" /etc/conf.d/keymaps
  rc-service keymaps restart
  rc-update add keymaps boot

  sed -i "s/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g" /etc/locale.gen
  locale-gen

  sed i "s/^hostname=\"localhost\"/hostname=\"skadi\"/g" /etc/conf.d/hostname
  ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

  emerge sys-kernel/installkernel-gentoo

  emerge sys-kernel/gentoo-kernel-bin

	if [ -d "/sys/firmware/efi" ]
	then
	  echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
  fi

  emerge sys-boot/grub

  emerge sys-fs/genfstab
  genfstab -U / >> /etc/fstab

	if [ -d "/sys/firmware/efi" ]
	then
	  grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
	else
	  grub-install --target=i386-pc /dev/sda
	fi

  grub-mkconfig -o /boot/grub/grub.cfg

  emerge net-misc/dhcpcd
  rc-update add dhcpcd default
  rc-service dhcpcd start
'

cd
umount -R /mnt/gentoo

reboot