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

dialog --title "Wipe Device" --clear \
       --msgbox "Secure deletion of all the data of a device" 10 30

dialog --title "WARNING"  \
       --msgbox "With this script you are going to destroy permanently all the data from a disk or a partition in general!!!!" 10 50


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
       --msgbox "Take a look at your disks structure and choose the device you want to wipe. All data will be destroyed." 10 50

#show disk partitions and devices
fdisk -l | grep /dev/sd > /tmp/tccf.cryptdevice.temp.wakawaka
dialog --title "Available Devices" --clear --textbox "/tmp/tccf.cryptdevice.temp.wakawaka" 20 80
rm /tmp/tccf.cryptdevice.temp.wakawaka

#enter the filename
dialog --title "Device to delete" --clear \
        --inputbox "Enter the full path of the device you want the data to be secure deleted" 16 51 2> /tmp/tccf.cryptdevice.temp.wakawaka
fnamevol=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

if [[ $fnamevol =~ /dev/sd[a-z][1-9] ]]
then
    echo "PATH WELL FORMED"
else
    echo
    echo "THIS IS NOT A DEVICE!!!"
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
dialog --title " Device DESTRUCTION " \
        --yesno "You are going to fill $fnamevol with random data in multiple passes\nOperation is extremely slow and permanently delete all the data. Continue?" 15 50

case $? in
  0)
    echo "Randomizing volume data"
    echo "Take a coffee... it will take long time";;
  1)
    echo "No chosen."
    exit 0;;
  255)
    echo "ESC pressed. Exiting!"
    exit 0;;
esac

echo "starting wiping"
raw=0
while (($raw < 7)); do
    clear
    echo "Wiping $fnamevol, it will be a clean job"
    echo "For hundreds of GigaBytes it will take several hours"
    echo "After 2 or 3 passes... maybe you can press CTRL+C to"
    echo "to stop the process. Data will be already wiped out"
    echo
    echo "$raw of 7 passes done"
    dd if=/dev/urandom of=$fnamevol bs=1024
    raw=$(($raw+1))
done
echo "-----------------------------------------"
echo "overwrite done!"

dialog --title "Yatta!!!" --clear \
       --msgbox "Device successfully wiped.\nHave a nice and secure day!\nyou have used TCCF by Giovanni Santostefano" 10 50
clear
