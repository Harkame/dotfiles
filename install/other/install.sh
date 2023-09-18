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
mount --mkdir /dev/sda2 /mnt/gentoo/boot/efi

cd /mnt/gentoo

wget https://distfiles.gentoo.org/releases/amd64/autobuilds/20230917T164636Z/stage3-amd64-openrc-20230917T164636Z.tar.xz

tar xpf stage

cd /mnt/gentoo
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run
cp /etc/resolv.conf etc