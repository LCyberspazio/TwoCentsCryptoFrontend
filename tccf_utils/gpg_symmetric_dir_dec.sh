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
dialog --title "Directory Decryption" --clear \
       --msgbox "Decrypt all files of a directory and subdirectory with a password.\n\nUseful if you have directories full of gpg encrypted files" 20 50
       
dialog --title "WARNING!!" --clear \
       --msgbox "Do not use on multiuser systems\nPassword will be visible in top or ps programs.\n\nAll encrypted files will be unsecurely DELETED\n\nBugs may cause loss of data. If you don't know how to use it securely, please quit the program now! I'm not responsible of any damage... as always\n\nIt doesn't works on filenames with spaces!\n\nIf data can't be decrypted, the original file won't be deleted" 20 60


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
sourcedir=`dialog --stdout --title "Select the directory to decrypt" --dselect $HOME/ 14 58`

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
dialog --title " Directory Decryption " \
        --yesno "Are you sure to decrypt and delete all the encrypted data in $sourcedir ?" 10 30

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

#password entry
clear
echo "Enter the passphrase. Strong!"
read -s  passphrase

clear
#finding the list of files in the directory
FILES=`find -P $sourcedir/ -name \*.asc -type f`
echo "Decrypting..."
for file in $FILES
do
    echo "Decrypting $file"
    gpg --passphrase $passphrase $file
    #decryption success! delete the encrypted file
    case $? in
	0)
	    echo "File decrypted"
	    echo "Deleting $file"
		rm $file;;
	2)
	    echo "Decryption failed"
		echo "Original encrypted file won't be deleted";;
    esac
    echo "----------------------------------------"
done

echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "All files in $sourcedir successfully decrypted and .asc file deleted" 18 60
