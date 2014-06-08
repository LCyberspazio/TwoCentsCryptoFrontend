#! /bin/bash

#CryptStorage  Copyright (C) 2014  Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.


clear
dialog --title "Key Generation" --clear \
       --msgbox "Before using gpg you have to create a key pair.\nThe public key will be released over the internet and used by your contact to send encrypted messages and file to you. The private key must be secret and with that you can decrypt messages or make digital signatures." 15 50


if [ -e "/usr/bin/gpg" ]
then
  echo "gpg installed!"
else
  echo
  echo
  echo "ERROR!!!"
  echo "gpg not found!"
  exit 2
fi


clear
#key generation
gpg --gen-key

dialog --title "Key Generation" --clear \
       --msgbox "Key pair has been generated.\nNow you have to export the public key in a file to be able to send it to your contacts or upload on a C.A. server" 10 60
dialog --title "Key Generation" --clear \
       --msgbox "Key will be exported in the file ${HOME}/${USER}-publickey.asc" 10 50
clear
gpg --armor --export > ${HOME}/${USER}-publickey.asc


clear
dialog --title "GOOD BYE!" --clear \
       --msgbox "Key pair created, share the exported public key with your contacts" 10 60

