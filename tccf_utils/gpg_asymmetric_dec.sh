#! /bin/bash

#CryptStorage  Copyright (C) 2014  Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.


clear
dialog --title "Private Key File Decryption" --clear \
       --msgbox "Decrypt a file with your private key" 10 50


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
sourcefile=`dialog --stdout --title "Select the file to decrypt" --fselect $HOME/ 14 58`

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

dialog --title "Filename of the decrypted file" --clear \
        --inputbox "Enter the full path of the file that will contain decrypted data" 16 51 2> /tmp/tccf.cryptdevice.temp.wakawaka
destination=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka


clear
echo "Decrypting..."
gpg -d $sourcefile > $destination
echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "$sourcefile\n decrypted in\n $destination" 15 60
