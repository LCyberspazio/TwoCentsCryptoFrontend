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
dialog --title "Directory Encryption" --clear \
       --msgbox "Encrypt of all files of a directory and subdirectory with a password.\n\nUseful to make DVDs with gpg encrypted backups usable on all gpg-ready systems, unlike LUKS filesystems" 20 50
       
dialog --title "WARNING!!" --clear \
       --msgbox "Do not use on multiuser systems\nPassword will be visible in top or ps programs.\n\nAll original files will be securely DELETED (2 overwriting only)\n\nBugs may cause loss of data. If you don't know how to use it securely, please quit the program now! I'm not responsible of any damage... as always\n\nIt doesn't works on filenames with spaces!" 20 60


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
sourcedir=`dialog --stdout --title "Select the directory to encrypt" --dselect $HOME/ 14 58`

case $? in
	0)
		echo "\"$sourcedir\" chosen";;
	1)
		echo "Cancel pressed."
        exit 0;;
	255)
		echo "Box closed."
        exit 0;;
esac

clear
dialog --title " Directory Encryption " \
        --yesno "Are you sure to encrypt and delete all the data in $sourcedir ?" 10 30

case $? in
  0)
    echo "Let's go!";;
  1)
    echo "No chosen. Exiting"
    exit 1;;
  255)
    echo "ESC pressed. Exiting!"
    exit 1;;
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

#password entry
clear
echo "Enter the passphrase. Strong!"
read -s  passphrase

clear
#finding the list of files in the directory
FILES=`find -P $sourcedir/ -name \* -type f`
echo "Encrypting..."
for file in $FILES
do
    echo "Encrypting $file -> $file.asc"
    gpg --symmetric --cipher $cipher --armor --passphrase $passphrase $file
    echo "Secure Deleting $file"
    ./guest/guest_wipefile $file
    echo "----------------------------------------"
done

echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "All files in $sourcedir successfully encrypted and deleted" 18 60
