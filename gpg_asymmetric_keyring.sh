#! /bin/bash

#
#Two Cents Crypto Frontend 0.1 - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Two Cents Crypto Frontend 0.2 - 2014 Software edited and modified by Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>



clear
dialog --title "Public Keys Address Book" --clear \
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
#Public key displayer

dialog --title "Public Address Book" --clear \
    gpg -k
