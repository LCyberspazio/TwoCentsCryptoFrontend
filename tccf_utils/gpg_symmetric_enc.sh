#! /bin/bash

#
#Two Cents Crypto Frontend - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Developer: Giovanni Santostefano <giovannisantostefano@email.it>
# Contributor: Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>

clear
dialog --title "File Encryption" --clear \
       --msgbox "Encrypt a file with a password" 10 30


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
#enter the filename
sourcefile=`dialog --stdout --title "Select the file to encrypt" --fselect $HOME/ 14 58`

case $? in
	0)
		echo "\"$sourcefile\" chosen";;
	1)
		echo "Cancel pressed."
        exit 0;;
	255)
		echo "Box closed."
        exit 0;;
esac

#encryption strength choice
dialog --clear --title "Cipher" \
        --menu "Choose your favorite cipher" 20 61 4 \
        "cast5"  "GPG default cipher" \
        "aes256" "US standard cipher" \
        "twofish"  "Two Fish cipher" 2> /tmp/tccf.cryptdevice.temp.wakawaka
retval=$?
cipher=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    echo "'$cipher' is your favorite cypher";;
  1)
    echo "Cancel pressed."
    exit 0;;
  255)
    echo "ESC pressed."
    exit 0;;
esac



clear
echo "Encrypting..."
gpg --symmetric --cipher $cipher --armor $sourcefile
echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "$sourcefile\n encrypted in\n$sourcefile.asc" 15 60
