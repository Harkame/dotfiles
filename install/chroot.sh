genfstab -p -U /mnt >> /mnt/etc/fstab

pacman -Sy networkmanager
systemctl enable NetworkManager.service

echo "KEYMAP=fr-latin9" >> /etc/vconsole.conf
echo "FONT=eurlatgr" >> /etc/vconsole.conf

echo "" >> /etc/pacman.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
echo "" >> /etc/pacman.conf
echo "[blackarch]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://blackarch.org/blackarch/\$repo/os/\$arch" >> /etc/pacman.conf

pacman -Syu

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --utc

echo "Skadi" >> /etc/hostname

mkdir /boot/grub/
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=esp --boot-directory=/mnt/boot --bootloader-id=GRUB /dev/sda

mkinitcpio -p linux

echo -e "mypassword\mypassword" | passwd root

useradd -m -g users -G wheel -s /bin/bash harkame
echo -e "mypassword\mypassword" | passwd harkame