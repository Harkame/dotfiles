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

mkfs.btrfs -L "Gentoo" -f -n 65536 /dev/sda3

mount --mkdir /dev/sda3 /mnt/gentoo
mount --mkdir /dev/sda1 /mnt/gentoo/boot
#mount --mkdir /dev/sda2 /mnt/gentoo/boot/efi

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
cp /etc/resolv.conf etc

chroot . bash -c '
  emerge-webrsync
  emerge -uDN @world

  echo -e "mypassword\nmypassword" | passwd root
  useradd -m -g users -G wheel -s /bin/bash harkame
  echo -e "mypassword\nmypassword" | passwd harkame
  sed -i "s/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers
  chown -R harkame /home/harkame

  sed -i "s/^keymap=\"us\"/keymap=\"fr\"/g"
  rc-service keymaps restart
  rc-update add keymaps boot

  sed -i "s/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g" /etc/locale.gen
  locale-gen

  sed i "s/^hostname=\"localhost\"/hostname=\"skadi\"/g" /etc/conf.d/hostname
  ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

  echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" | tee -a /etc/portage/package.license

  emerge sys-kernel/gentoo-sources sys-kernel/linux-firmware*
  cd /usr/src/linux*

  emerge pciutils

  make localyesconfig
  make -j2

  make modules_install
  make install

  echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
  emerge sys-boot/grub

  grub-mkconfig -o /boot/grub/grub.cfg
  #grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB --recheck

  emerge net-misc/dhcpcd
  rc-update add dhcpcd default
  rc-service dhcpcd start
'
umount -R /mnt/gentoo