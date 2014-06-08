#! /bin/bash

#
#Two Cents Crypto Frontend 0.1 - Copyright (C) 2014  Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Two Cents Crypto Frontend 0.2 - 2014 Software edited and modified by Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>

MPOINT=$HOME/tccf_cryptvol



while :
do

clear

#encryption strength choice
dialog --clear --title "TCCF Module Selection" \
        --menu "Choose your activity" 15 60 5 \
        "Storage"  "Manage storage encryption" \
        "File" "Encrypt/Decrypt single files with password" \
        "GPG"  "Manage asymmetric encryption/signature" \
        "Wipe" "Secure deletion of disks" \
        "Quit" "Exit from TCCF"  2> /tmp/tccf.cryptdevice.temp.wakawaka
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
    elif [[ $action =~ "GPG" ]]
    then
        clear
        bash tccf_gpg_asymmetric_mod.sh
    elif [[ $action =~ "Wipe" ]]
    then
        clear
        bash tccf_wipe_mod.sh
    elif [[ $action =~ "Quit" ]]
    then
        clear
        exit 0
    else
        clear
        #for future implementations
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

done