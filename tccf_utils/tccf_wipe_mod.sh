#! /bin/bash

#
#Two Cents Crypto Frontend - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Developer: Giovanni Santostefano <giovannisantostefano@email.it>
# Contributor: Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>

#encryption strength choice
dialog --clear --title "Secure deletion" \
        --menu "Choose your activity" 10 60 3 \
        "Device"  "Wipe out a device" \
        "File" "Wipe a single file" 2> /tmp/tccf.cryptdevice.temp.wakawaka
retval=$?
action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    if [[ $action =~ "Device" ]]
    then
        clear
        sudo bash wipe_device.sh
    elif [[ $action =~ "File" ]]
    then
        clear
        bash wipe_file.sh
    else
        clear
        echo "eventually add..."
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
