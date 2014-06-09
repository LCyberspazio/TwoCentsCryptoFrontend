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
dialog --title "File Digital Signing" --clear \
       --msgbox "Digitally sign a file with your private key" 10 50


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
sourcefile=`dialog --stdout --title "Select the file to sign" --fselect $HOME/ 14 58`

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
echo "Signing..."
gpg --detach-sign --armor $sourcefile 

echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "$sourcefile\n signature stored in\n$sourcefile.asc" 15 60
