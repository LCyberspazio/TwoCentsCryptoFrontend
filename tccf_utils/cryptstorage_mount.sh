#! /bin/bash

#
#Two Cents Crypto Frontend - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Developer: Giovanni Santostefano <giovannisantostefano@email.it>
# Contributor: Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>

LOOP_DEV=/dev/loop0
CRYPT_NAME=gscryptstorage
MPOINT=$HOME/tccf_cryptvol

clear
dialog --title "Mount Encrypted Storage" --clear \
       --msgbox "Mount encrypted storage contained in a file" 10 30


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
   echo "So, if you don't want root on the system"
   echo "use sudo or some other shit"
   exit 9
fi

#test for mount point
if [ -d "$MPOINT" ]
then
  echo "mount point found!"
else
  echo "Creating mount point"
  mkdir $MPOINT
fi

clear
#enter the filename
fnamevol=`dialog --stdout --title "Choose the encrypted storage" --fselect $HOME/ 14 58`

case $? in
	0)
		echo "\"$fnamevol\" chosen";;
	1)
		echo "Cancel pressed."
        exit 0;;
	255)
		echo "Box closed."
        exit 0;;
esac


if [ -e "$fnamevol" ]
then
  echo "voume exists!"
else
  echo
  echo
  echo "ERROR!!!"
  echo "Filename not found!"
  exit 6
fi

clear
echo "Defining loop device"
losetup $LOOP_DEV $fnamevol
echo
echo "Opening the device"
cryptsetup luksOpen $LOOP_DEV $CRYPT_NAME
echo
echo "mounting the device in the $MPOINT directory"
mount  /dev/mapper/$CRYPT_NAME $MPOINT/
clear

dialog --title "IMPORTANT!" --clear \
       --msgbox "Volume mounted in $MPOINT \n When you finish using the mounted volume, hit ENTER to close this dialog and volume will be unmounted.\n\nDo not press OK or ENTER now but only when you want to unmount the volume ok?" 20 40

echo
echo "OK! Almost done! Let's close everything"
umount /dev/mapper/$CRYPT_NAME
cryptsetup luksClose /dev/mapper/$CRYPT_NAME
losetup -d $LOOP_DEV
echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "Device unmounted. Have a nice, secure day!" 10 40
