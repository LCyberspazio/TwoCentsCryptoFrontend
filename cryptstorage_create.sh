#! /bin/bash

#Two Cents Crypto Frontend Copyright (C) 2014  Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.

#Cryptstorage allow the user to create, mount and unmount
#an encrypted storage maintained in a file!
#Beware! It requires always root privileges!

#THIS SCRIPT CAN SERIOUSLY DAMAGE YOUR SYSTEM!
#USE IT AT YOUR OWN RISK!
#HOW CAN I SAY YOU... IF THIS FUCK YOUR SYSTEM
#THIS IS YOUR ONLY PROBLEM! 
#NO COSPIRACY ;)

LOOP_DEV=/dev/loop0
CRYPT_NAME=gscryptstorage

dialog --title "Encrypted Storage" --clear \
       --msgbox "Create encrypted storage in a regular file" 10 30

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
   echo "So, if you don't want root on the system"
   echo "use sudo or some other shit"
   exit 9
fi

#enter the filename
dialog --title "Filename of the Storage" --clear \
        --inputbox "Enter the full path of the encrypted storage you want to create \n(Warning: if file already exists will be overwritter!!!)" 16 51 2> /tmp/tccf.cryptdevice.temp.wakawaka
fnamevol=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

#enter the size
dialog --title "Size of the Storage" --clear \
        --inputbox "Enter the storage size in MegaBytes MB" 16 51 2> /tmp/tccf.cryptdevice.temp.wakawaka
mbyte=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

clear
echo "Creating the volume in the file"
dd if=/dev/urandom of=$fnamevol bs=1M count=$mbyte
echo "Volume created"
echo

#encryption strength choice
dialog --clear --title "Cypher" \
        --menu "Choose your favorite cypher" 20 61 4 \
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
       --msgbox "$fnamevol storage successfully encrypted.\nHave a nice and secure day!\nyou have used TCCF by Giovanni Santostefano" 10 50
clear
