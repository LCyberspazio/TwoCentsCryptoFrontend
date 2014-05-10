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

MPOINT=$HOME/tccf_cryptvol

#encryption strength choice
dialog --clear --title "Container Encrypt Module" \
        --menu "Choose your activiry" 20 60 4 \
        "Device"  "Encrypt Device or partition" \
        "Storage" "Create and encrypted storage in a file" \
        "Mount"  "Mount encrypted device/file" 2> /tmp/tccf.cryptdevice.temp.wakawaka
retval=$?
action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    if [[ $action =~ "Device" ]]
    then
        clear
        echo "THIS SCRIPT NEEDS ROOT PRIVILEGES"
        echo
        sudo bash cryptdevice_create.sh
    elif [[ $action =~ "Storage" ]]
    then
        clear
        echo "THIS SCRIPT NEEDS ROOT PRIVILEGES"
        echo
        sudo bash cryptstorage_create.sh
    else
        clear
        echo "THIS SCRIPT NEEDS ROOT PRIVILEGES"
        echo
        #test for mount point
        if [ -d "$MPOINT" ]
        then
          echo "mount point found!"
        else
          echo "Creating mount point"
          mkdir $MPOINT
        fi
        sudo bash cryptstorage_mount.sh
    fi
    echo "'$action'";;
  1)
    echo "Cancel pressed."
    #remember to launch back the top script
    exit 0;;
  255)
    echo "ESC pressed."
    exit 0;;
esac
