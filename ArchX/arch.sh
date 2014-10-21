#!/bin/bash

# Pre-install script for ArchX

archx="
    /\            | |   \ \ / /
   /  \   _ __ ___| |__  \ V / 
  / /\ \ | '__/ __| '_ \  > <  
 / ____ \| | | (__| | | |/ . \ 
/_/    \_\_|  \___|_| |_/_/ \_\
"

echo "------------------------------------------"
echo "$archx"
echo ""
echo "Automated Arch installer script v0.1"
echo "by"
echo "IronicBadger" 
echo "Last Updated: Oct 2014"
echo "------------------------------------------"

echo -n "Enter 'sdX' for installation. e.g. 'sda': "
read devsdx
echo "------------------------------------------"
echo "The following parameters will be used: "
echo "Drive to FULLY WIPED and partitioned: $devsdx"
echo ""
echo "WARNING!! THIS WILL ERASE /dev/$devsdx"
echo "ARE YOU SURE ABOUT THIS?"
echo ""
echo "Is this correct, do you want to start installation? [y/n]"
read quit
if [ "$quit" != "y" ]; then
	echo "Rerun script with correct input."
	echo "User exited."
	exit 0
fi
echo "------------------------------------------"

##
# Partitioning
###

devpart=/dev/$devsdx"1"
echo "o
n
p
1


w" | fdisk /dev/$devsdx
mkfs.ext4 $devpart
mount $devpart /mnt
pacstrap /mnt base base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash -c "source <(curl https://raw.githubusercontent.com/krunchyal/dotfiles/master/ArchX/install.sh)"

echo "If you're reading this, then everything is complete? :)"

echo ""
echo "------------------------------------------"
echo "$archx"
echo "------------------------------------------"