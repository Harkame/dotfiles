wipefs -af /dev/sda
return
parted -a optimal /dev/sda mklabel gpt mkpart primary linux-swap 0% 4096MB
parted -a optimal /dev/sda mkpart primary 4096MB 100%



pacstrap /mnt base base-devel networkmanager grub btrfs-progs mkinitcpio linux git

mkswap /dev/sda1
swapon /dev/sda1

mkfs.ext4 -L "Boot" /dev/sda1
mkfs.btrfs -L "Arch" -f -n 65536 /dev/sda2

mount /dev/sda2 /mnt

sed -i "s/Server/#Server/g" /etc/pacman.d/mirrorlist
#uncomment the choosen one>

pacstrap /mnt base base-devel networkmanager grub btrfs-progs linux
genfstab -p -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

	systemctl enable NetworkManager.service

	echo "KEYMAP=fr-latin9" >> /etc/vconsole.conf
	echo "FONT=eurlatgr" >> /etc/vconsole.conf

	sed -i "s/#fr_FR.UTF-8/fr_FR.UTF-8/g" /etc/locale.gen

	nano /etc/pacman.conf
		[archlinuxfr]
		SigLevel = Never
		Server = http://repo.archlinux.fr/$arch

		[blackarch]
		SigLevel = Never
		Server = http://blackarch.org/blackarch/$repo/os/$arch

	pacman -Syu

	echo "LANG=fr_FR.UTF-8" >> /etc/locale.conf
	echo "LC_COLLATE=C" >> /etc/locale.conf

	export LANG=fr_FR.UTF-8
	locale-gen

	ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
	hwclock --systohc --utc

	echo "Skadi" >> /etc/hostname

	mkdir /boot/grub/
	grub-mkconfig -o /boot/grub/grub.cfg
	grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB /dev/sda

	mkinitcpio -p linux

	passwd root
		~
		~

	useradd -m -g users -G wheel -s /bin/bash harkame
	passwd harkame
		~
		~

exit

umount -R /mnt

reboot

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
