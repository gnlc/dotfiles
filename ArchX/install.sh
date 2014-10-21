#!/bin/bash

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
echo "We are now in arch-chroot!"
echo ""
read -p "Press [Enter] to continue your installation."
echo "------------------------------------------"

###
# Initial Setup
###

# Defaults
DOTFILES='/root/dotfiles'
USER='alex'

echo -n "Please drive to install GRUB on. /dev/sdXY: "
read devgrub
echo -n "Please enter desired password for '$USER' (shown cleartext!): "
read userpw

echo ArchX > /etc/hostname
echo en_GB.UTF-8 UTF-8 > /etc/locale.gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
export LANG=en_GB.UTF-8
echo archey3 >> /etc/bash.bashrc
echo export EDITOR=nano >> /etc/bash.bashrc

locale-gen
mkinitcpio -p linux
ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc --utc

###
# Adding Repos
###
echo "Adding repos..."
echo "" >> /etc/pacman.conf
echo [multilib] >> /etc/pacman.conf
echo Include = /etc/pacman.d/mirrorlist >> /etc/pacman.conf
echo "" >> /etc/pacman.conf
echo [archlinuxfr] >> /etc/pacman.conf
echo SigLevel = Never >> /etc/pacman.conf
echo Server = http://repo.archlinux.fr/\$arch >> /etc/pacman.conf

###
# My base software utils
###
echo "Base software utils being setup..."
pacman -Syy --noconfirm sudo wget openssh grub
pacman -S --noconfirm git archey3 packer docker screen htop
git clone https://github.com/krunchyal/dotfiles.git $DOTFILES/
cd $DOTFILES/

###
# Networking
###
echo "Networking being setup..."
cp $DOTFILES/ArchX/ethernet /etc/netctl/ethernet
cp $DOTFILES/ArchX/bridge /etc/netctl/bridge
netctl enable ethernet
netctl enable bridge

###
# User setup
###
useradd -m -g users -p $userpw -s /bin/bash $USER
usermod -a -G wheel $USER
echo %wheel ALL=\(ALL\) NOPASSWD: ALL >> /etc/sudoers

###
# Build setup
###
echo MAKEFLAGS="-j4" >> /etc/makepkg.conf

###
# Services
###
systemctl enable docker
systemctl enable sshd

###
# GRUB
###
grub-install --target=i386-pc --recheck /dev/$devgrub
grub-mkconfig -o /boot/grub/grub.cfg

###
# SnapRAID
###
cp $DOTFILES/ArchX/snapraid.conf /etc/snapraid.conf
packer --noconfirm -S snapraid
packer --noconfirm -S mhddfs

###
# fstab
###

echo "" >> /etc/fstab
echo "# SnapRAID Disks" >> /etc/fstab
echo "/dev/disk/by-id/ata-WDC_WD30EFRX-68AX9N0_WD-WMC1T0074096-part1            /mnt/disk1 xfs defaults 0 2" >> /etc/fstab
echo "/dev/disk/by-id/ata-WDC_WD30EFRX-68AX9N0_WD-WCC1T0632015-part1            /mnt/disk2 xfs defaults 0 2" >> /etc/fstab
echo "/dev/disk/by-id/ata-Hitachi_HDS5C3030ALA630_MJ1311YNG5SD3A-part1          /mnt/disk3 xfs defaults 0 2" >> /etc/fstab
echo "/dev/disk/by-id/ata-Hitachi_HDS5C3030ALA630_MJ1311YNG4GE8A-part1          /mnt/disk4 xfs defaults 0 2" >> /etc/fstab
echo "/dev/disk/by-id/ata-TOSHIBA_DT01ACA300_43LNPGSGS-part1  /mnt/disk5 xfs defaults 0 2" >> /etc/fstab
echo "" >> /etc/fstab
echo "# SnapRAID Parity Disks" >> /etc/fstab
echo "/dev/disk/by-id/ata-TOSHIBA_DT01ACA300_X3544DGKS-part1                  /mnt/parity1 xfs defaults 0 2" >> /etc/fstab
echo "" >> /etc/fstab
echo "# MHDDFS" >> /etc/fstab
echo "mhddfs#/mnt/disk1,/mnt/disk2,/mnt/disk3,/mnt/disk4,/mnt/disk5 /mnt/storage fuse defaults,allow_other,nonempty,mlimit=50G 0 0" >> /etc/fstab

###
# Finishing off
###

echo ""
echo "-----------------"
echo "You should connect data drives before rebooting."
echo "-----------------"
echo ""
echo "CHROOT script complete..."
