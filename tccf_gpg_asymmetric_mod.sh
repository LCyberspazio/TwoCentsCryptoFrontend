#! /bin/bash

#
#Two Cents Crypto Frontend 0.1 - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Two Cents Crypto Frontend 0.2 - 2014 Software edited and modified by Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>



#encryption strength choice
dialog --clear --title "Asymmetric Encrypt Module" \
        --menu "Choose your activity" 15 60 6 \
        "keyring" "Display your PUBLIC Keys Address Book" \
        "Keyring" "Display your PRIVATE Keys available" /
        "AddKey"  "Add someone's public key to keyring" \
        "Genkey"  "Generate a new key pair" \
        "Encrypt"  "Encrypt file with someone's public key" \
        "Decrypt" "Decrypt file with your private key" \
        "Sign" "Apply a digital signature to a file" \
        "Verify" "Verify a digital signature with the file" 2> /tmp/tccf.cryptdevice.temp.wakawaka
        
retval=$?
action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    if [[ $action =~ "Genkey" ]]
    then
        clear
        bash gpg_asymmetric_keygen.sh
    elif [[ $action =~ "AddKey" ]]
    then
        clear
        bash gpg_asymmetric_addpub.sh
    elif [[ $action =~ "keyring" ]]
    then
        clear
        bash gpg_asymmetric_keyring.sh
    elif [[ $action =~ "Keyring" ]]
    then
        clear
        bash gpg_asymmetric_Keyring.sh
    elif [[ $action =~ "Encrypt" ]]
    then
        clear
        bash gpg_asymmetric_enc.sh
    elif [[ $action =~ "Decrypt" ]]
    then
        clear
        bash gpg_asymmetric_dec.sh
    elif [[ $action =~ "Sign" ]]
    then
        clear
        bash gpg_asymmetric_sign.sh
    elif [[ $action =~ "Verify" ]]
    then
        clear
        bash gpg_asymmetric_verify.sh
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
