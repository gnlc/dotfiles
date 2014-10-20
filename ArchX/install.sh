#!/bin/bash

# MUST BE RUN WITH CHROOT DURING INSTALLATION
# Install script for ArchX

# Defaults
DOTFILES='/root/dotfiles'
USER='alex'

echo "------------------------------------------"
read -p "Press [Enter] To Start your Installation"
echo "------------------------------------------"

###
# Initial Setup
###

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
pacman -S --noconfirm git archey3 packer docker screen htop mhddfs
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
echo -n "Please enter password for '$USER' (this will be shown cleartext!): "
read userpw
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
echo -n "Enter 'sdX' for grub installation. e.g. 'sda': "
read grubdev
grub-install --target=i386-pc --recheck /dev/$grubdev
grub-mkconfig -o /boot/grub/grub.cfg

###
# SnapRAID
###
cp $DOTFILES/ArchX/snapraid.conf /etc/snapraid.conf
packer -noconfirm -S snapraid

echo ""
echo "-----------------"
echo "You should connect data drives before rebooting."
echo "-----------------"
echo ""
echo "Script complete..."
