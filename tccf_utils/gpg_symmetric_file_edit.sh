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
dialog --title "Encrypted Text File Edit" --clear \
       --msgbox "Edit a text file encrypted with a password" 10 50
       
dialog --title "WARNING!!" --clear \
       --msgbox "Do not use on multiuser systems\nPassword will be visible in top or ps programs.\n\nBugs may cause loss of data. If you don't know how to use it securely, please quit the program now! I'm not responsible of any damage... as always." 20 60


if [ -e "/usr/bin/gpg" ]
then
  echo "gpg installed!"
else
  echo
  echo
  echo "ERROR!!!"
  echo "gpg not found!"
  read
  exit 2
fi

clear
#enter the filename
sourcefile=`dialog --stdout --title "Select the file to edit" --fselect $HOME/ 14 58`

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

#password entry
clear
echo "Enter the passphrase to unlock and reencrypt $sourcefile"
read -s  passphrase

clear

#decrypting
gpg -d --passphrase $passphrase $sourcefile > $sourcefile.temp.wawa

if [ $? -ne 0 ]; then
    echo "decryption error"
    rm $sourcefile.temp.wawa
    read
    exit 2
fi

#editing
nano $sourcefile.temp.wawa
#encrypting
gpg --symmetric --cipher $cipher --armor --passphrase $passphrase -o $sourcefile $sourcefile.temp.wawa
#clear text secure deletion
echo "Secure Deleting $sourcefile.temp.wawa"
./guest/guest_wipefile $sourcefile.temp.wawa
./guest/guest_wipefile $sourcefile.temp.wawa~

echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "$sourcefile edit complete" 18 60
