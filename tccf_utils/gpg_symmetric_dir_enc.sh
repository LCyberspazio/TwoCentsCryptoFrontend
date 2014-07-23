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
       --msgbox "Do not use on multiuser systems\nPassword will be visible in top or ps programs.\n\nAll original files will be securely DELETED\n\nBugs may cause loss of data. If you don't know how to use it securely, please quit the program now! I'm not responsible of any damage... as always" 20 60


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

if [ -e "/usr/bin/srm" ]
then
  echo "secure delete installed!"
else
  echo
  echo
  echo "ERROR!!!"
  echo "srm (secure-delete) not found!"
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

#password entry
clear
echo "Enter the passphrase. Strong!"
read -s  passphrase

clear
#finding the list of files in the directory
FILES=`find $sourcedir/ -name \*`
echo "Encrypting..."
for file in $FILES
do
    echo "Encrypting $file -> $file.asc"
    gpg -c --armor --passphrase $passphrase $file
    echo "Secure Deleting $file"
    srm $file
    echo "----------------------------------------"
done

echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "All files in $sourcedir successfully encrypted and deleted" 18 60
