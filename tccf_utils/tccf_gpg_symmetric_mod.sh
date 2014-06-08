#! /bin/bash

#Two Cents Crypto Frontend Copyright (C) 2014  Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.

#encryption strength choice
dialog --clear --title "File Symmetric Encrypt Module" \
        --menu "Choose your activity" 10 60 3 \
        "Encrypt"  "Encrypt file with password" \
        "Decrypt" "Decrypt file with password" 2> /tmp/tccf.cryptdevice.temp.wakawaka
retval=$?
action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    if [[ $action =~ "Encrypt" ]]
    then
        clear
        bash gpg_symmetric_enc.sh
    elif [[ $action =~ "Decrypt" ]]
    then
        clear
        bash gpg_symmetric_dec.sh
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
