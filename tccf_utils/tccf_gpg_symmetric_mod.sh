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
while :
do
dialog --clear --title "File Symmetric Encrypt Module" \
        --menu "Choose your activity" 16 60 6 \
        "Encrypt"  "Encrypt file with password" \
        "Decrypt" "Decrypt file with password" \
        "Sdir" "Encrypt directory recursively" \
        "Cdir" "Decrypt directory recursively" \
        "Tedit" "Edit text encrypted file" 2> /tmp/tccf.cryptdevice.temp.wakawaka
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
    elif [[ $action =~ "Sdir" ]]
    then
        clear
        bash gpg_symmetric_dir_enc.sh
    elif [[ $action =~ "Cdir" ]]
    then
        clear
        bash gpg_symmetric_dir_dec.sh
    elif [[ $action =~ "Tedit" ]]
    then
        clear
        bash gpg_symmetric_file_edit.sh
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
done
