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
dialog --title "PubKey File Encryption" --clear \
       --msgbox "Encrypt a file with your contact's public key" 10 30


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

dialog --title "Recipient" --clear \
       --msgbox "Take a look at your keyring and then choose the contact (inserting the email or the ID) who the encrypted file is destinated." 15 50
clear
gpg --list-keys
echo
echo
echo -n "Insert the email or id of the contact: "
read recipient

clear
echo "Encrypting..."
gpg --encrypt --recipient $recipient --armor $sourcefile 

echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "$sourcefile\n encrypted in\n$sourcefile.asc\nwith the public key of\n $recipient" 15 60
