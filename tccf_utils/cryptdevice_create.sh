#! /bin/bash

#
#Two Cents Crypto Frontend - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Developer: Giovanni Santostefano <giovannisantostefano@email.it>
# Contributor: Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>

LOOP_DEV=`losetup -f` #find the first free loop device and set it
CRYPT_NAME=gscryptstorage

dialog --title "Encrypt Device" --clear \
       --msgbox "Create encrypted devices like usb pen, sd memory or disk partitions" 10 30

dialog --title "WARNING"  \
       --msgbox "With this script you can do lots of damage!\nCheck the script first and then use it if you know what to do. Otherwise CTRL+C" 10 50



if [ -e "$LOOP_DEV" ]
then
  echo "Loop device checked!"
else
  echo
  echo
  echo "ERROR!!!"
  echo "Please, edit the script with a valid loop device"
  exit 1
fi


if [ -e "/sbin/cryptsetup" ]
then
  echo "cryptsetup installed!"
else
  echo
  echo
  echo "ERROR!!!"
  echo "Cryptsetup not found!"
  exit 2
fi


clear
#please give me root
if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions"
   echo "So, if you don't want to root on the system"
   echo "use sudo or some other shit"
   exit 9
fi

#watch up the /dev table
dialog --title "Disks and Partitions"  \
       --msgbox "Take a look at your disks structure and choose the device you want to wipe, format and encrypt" 10 50

#show disk partitions and devices
fdisk -l | grep /dev/sd > /tmp/tccf.cryptdevice.temp.wakawaka
dialog --title "Available Devices" --clear --textbox "/tmp/tccf.cryptdevice.temp.wakawaka" 20 80
rm /tmp/tccf.cryptdevice.temp.wakawaka

#enter the filename
dialog --title "Device to Encrypt" --clear \
        --inputbox "Enter the full path of the device you want to encrypt \n(Warning: all device data is about to be wiped out!!!)" 16 51 2> /tmp/tccf.cryptdevice.temp.wakawaka
fnamevol=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

if [[ $fnamevol =~ /dev/sd[a-z][1-9] ]]
then
    echo "PATH WELL FORMED"
else
    echo
    echo "THIS IS NOT A DEVICE!!!"
    echo "What's with you!"
    echo "If I have not blocked the script now"
    echo "You'll had the hard disk filled of random data"
    echo
    echo "Incredible..."
    echo "Use device like /dev/sdc56... for example"
    exit 10
fi

if [ -e $fnamevol ]
then
  echo "device exists"
else
  echo
  echo
  echo "ERROR!!!"
  echo "Device not found!"
  exit 11
fi

clear
dialog --title " Device Randomization " \
        --yesno "Do you want to fill $fnamevol with random data?\nOperation is extremely slow but rise the security of the encrypted device" 10 30

case $? in
  0)
    echo "Randomizing volume data"
    echo "Take a coffee... it will take long time"
    echo "on 2GB usb2 volume it may take half an hour"
    dd if=/dev/urandom of=$fnamevol
    echo "Volume random filled";;
  1)
    echo "No chosen.";;
  255)
    echo "ESC pressed. Exiting!"
    exit 0;;
esac

#encryption strength choice
dialog --clear --title "Cipher" \
        --menu "Choose your favorite cipher" 20 61 4 \
        "aes-cbc-essiv:sha256"  "Low Security/Fast" \
        "twofish-cbc-essiv:sha256" "Good Security/Slow" \
        "serpent-cbc-essiv:sha256"  "High Security/Very Slow" 2> /tmp/tccf.cryptdevice.temp.wakawaka
retval=$?
cipher=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    echo "'$cipher' is your favorite cypher";;
  1)
    echo "Cancel pressed."
    exit 0;;
  255)
    echo "ESC pressed."
    exit 0;;
esac

#finally create the encrypted volume
echo
echo "Defining loop device"
losetup $LOOP_DEV $fnamevol
echo "Formatting as luks volume"
cryptsetup -c $cipher -s 256 -y luksFormat $LOOP_DEV
echo
echo "Please, reinsert the password one more time"
cryptsetup luksOpen $LOOP_DEV $CRYPT_NAME
echo
echo "Formatting the crypt device as FAT32"
mkdosfs /dev/mapper/$CRYPT_NAME
echo
echo "OK! Almost done! Let's close everything"
cryptsetup luksClose /dev/mapper/$CRYPT_NAME
losetup -d $LOOP_DEV

dialog --title "Yatta!!!" --clear \
       --msgbox "Device successfully encrypted.\nHave a nice and secure day!\nyou have used TCCF by Giovanni Santostefano" 10 50
clear
