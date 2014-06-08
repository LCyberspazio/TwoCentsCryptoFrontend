#! /bin/bash

#
#Two Cents Crypto Frontend 0.1 - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Two Cents Crypto Frontend 0.2 - 2014 Software edited and modified by Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>


#encryption submenu
PKEncription(){
    dialog --clear --title "Asymmetric Encrypt Module" \
        --menu "Choose your activity" 15 60 4 \
        "Encrypt"  "Encrypt file with someone's public key" \
        "Decrypt" "Decrypt file with your private key"  2> /tmp/tccf.cryptdevice.temp.wakawaka
    
    retval=$?
    action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
    rm /tmp/tccf.cryptdevice.temp.wakawaka
    
    case $retval in
      0)
        if [[ $action =~ "Encrypt" ]]
        then
            clear
            bash gpg_asymmetric_enc.sh
        elif [[ $action =~ "Decrypt" ]]
        then
            clear
            bash gpg_asymmetric_dec.sh
        else
            clear
            echo "eventually add..."
        fi
        echo "'$action'";;
      1)
        echo "Cancel pressed."
        #remember to launch back the top script
        return ;;
      255)
        echo "ESC pressed."
        return ;;
    esac
}


#signature submenu
PKSignature(){
    dialog --clear --title "Digital Signature Module" \
        --menu "Choose your activity" 15 60 6 \
        "Sign" "Apply a detached signature to a file" \
        "Verify" "Verify a detached signature with the file" \
        "---" "-----------------------------------" \
        "CSign" "Apply a digital signature to a txt file" \
        "TVer" "Verify a txt message digitally signed" 2> /tmp/tccf.cryptdevice.temp.wakawaka
    
    retval=$?
    action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
    rm /tmp/tccf.cryptdevice.temp.wakawaka
    
    case $retval in
      0)
        if [[ $action =~ "Sign" ]]
        then
            clear
            bash gpg_asymmetric_sign.sh
        elif [[ $action =~ "Verify" ]]
        then
            clear
            bash gpg_asymmetric_verify.sh
        elif [[ $action =~ "CSign" ]]
        then
            clear
            bash gpg_asymmetric_clear_sign.sh
        elif [[ $action =~ "TVer" ]]
        then
            clear
            bash gpg_asymmetric_clear_verify.sh
        else
            clear
            echo "eventually add..."
        fi
        echo "'$action'";;
      1)
        echo "Cancel pressed."
        #remember to launch back the top script
        return ;;
      255)
        echo "ESC pressed."
        return ;;
    esac
}

#key management submenu
KeyManager(){
    dialog --clear --title "Key Management Module" \
        --menu "Choose your activity" 15 60 4 \
        "Genkey"  "Generate a new key pair" \
        "Keyring" "Display your PUBLIC Keys Address Book" \
        "PKring" "Display your PRIVATE Keys available" \
        "AddKey"  "Add someone's public key to keyring"  2> /tmp/tccf.cryptdevice.temp.wakawaka
    
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
        elif [[ $action =~ "Keyring" ]]
        then
            clear
            bash gpg_asymmetric_keyring.sh
        elif [[ $action =~ "PKring" ]]
        then
            clear
            bash gpg_asymmetric_private_keyring.sh
        else
            clear
            echo "eventually add..."
        fi
        echo "'$action'";;
      1)
        echo "Cancel pressed."
        #remember to launch back the top script
        return ;;
      255)
        echo "ESC pressed."
        return ;;
    esac
}



#MAIN
#encryption strength choice
dialog --clear --title "GPG Module" \
        --menu "Choose your activity" 15 60 6 \
        "KeyMan" "Key Management" \
        "Encrypt" "Encryption/Decryption tools" \
        "Signing" "Signature tools" 2> /tmp/tccf.cryptdevice.temp.wakawaka
        
retval=$?
action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    if [[ $action =~ "KeyMan" ]]
    then
        clear
        KeyManager
    elif [[ $action =~ "Encrypt" ]]
    then
        clear
        PKEncription
    elif [[ $action =~ "Signing" ]]
    then
        clear
        PKSignature
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
