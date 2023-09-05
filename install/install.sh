#!/bin/bash

umount -R /mnt
wipefs -af /dev/sda

parted -a optimal /dev/sda mklabel gpt mkpart primary linux-swap 0% 4096MB
parted -a optimal /dev/sda mkpart primary 4096MB 100%

echo -e "set 2 boot on" | parted /dev/sda
