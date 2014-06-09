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
dialog --title "Add Public Key" --clear \
       --msgbox "Add a Public Key file to your keyring" 10 30


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
sourcefile=`dialog --stdout --title "Select the public key file" --fselect $HOME/ 14 58`

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


clear
echo "Adding the Key..."
gpg --import $sourcefile
case $? in
	0)
		dialog --title "GOOD BYE!" --clear \
       		--msgbox "Key successfully added to your keyring" 15 60;;
	2)
        dialog --title "ERROR!" --clear \
       		--msgbox "Invalid key file" 15 60
        exit 2;;
esac

