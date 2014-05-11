#! /bin/bash

#Two Cents Crypto Frontend Copyright (C) 2014  Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.

MPOINT=$HOME/tccf_cryptvol

clear
dialog --title "[ TCCF ]" --clear \
       --msgbox "Two Cents Crypto Frontend\n An easy to use set of cryptographic frontends developed by Giovanni Santostefano.\n Use it to easly perform encryption tasks.\n\n Visit http://twocentssecurity.wordpress.com for more info about computer security." 15 50

#encryption strength choice
dialog --clear --title "Module Selection" \
        --menu "Choose your activiry" 10 60 4 \
        "Storage"  "Manage storage encryption" \
        "File" "Encrypt/Decrypt single files with password" \
        "RSA"  "Manage asymmetric encryption" 2> /tmp/tccf.cryptdevice.temp.wakawaka
retval=$?
action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    if [[ $action =~ "Storage" ]]
    then
        clear
        bash tccf_device_mod.sh
    elif [[ $action =~ "File" ]]
    then
        clear
        bash tccf_gpg_symmetric_mod.sh
    else
        clear
        #bash cryptstorage_mount.sh
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
