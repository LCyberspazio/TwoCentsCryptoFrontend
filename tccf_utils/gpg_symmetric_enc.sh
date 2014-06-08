#! /bin/bash

#CryptStorage  Copyright (C) 2014  Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.

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


clear
echo "Encrypting..."
gpg -c --armor $sourcefile
echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "$sourcefile\n encrypted in\n$sourcefile.asc" 15 60
