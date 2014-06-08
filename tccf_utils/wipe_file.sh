#! /bin/bash

#Two Cents Crypto Frontend Copyright (C) 2014  Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.

#Cryptstorage allow the user to create, mount and unmount
#an encrypted storage maintained in a file!
#Beware! It requires always root privileges!

#THIS SCRIPT CAN SERIOUSLY DAMAGE YOUR SYSTEM!
#USE IT AT YOUR OWN RISK!
#HOW CAN I SAY YOU... IF THIS FUCK YOUR SYSTEM
#THIS IS YOUR ONLY PROBLEM! 
#NO COSPIRACY ;)

dialog --title "Wipe File" --clear \
       --msgbox "Secure deletion of all the data of a file" 10 30

dialog --title "WARNING"  \
       --msgbox "With this script you are going to destroy permanently all the data from a file." 10 50


clear

#enter the filename
#enter the filename
sourcefile=`dialog --stdout --title "Select the file to wipe" --fselect $HOME/ 14 58`

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

if [ -e $sourcefile ]
then
  echo "file exists"
else
  echo
  echo
  echo "ERROR!!!"
  echo "File not found!"
  exit 11
fi

clear
dialog --title " File DESTRUCTION " \
        --yesno "You are going to fill $sourcefile with random data in multiple passes\nOperation is extremely slow and permanently delete all de data. Continue?" 15 50

case $? in
  0)
    echo "Randomizing file data and deleting it"
    echo "Take a coffee... it will take long time";;
  1)
    echo "No chosen."
    exit 0;;
  255)
    echo "ESC pressed. Exiting!"
    exit 0;;
esac


if [ -e "/usr/bin/srm" ]
then
  echo "using srm!"
  srm -v $sourcefile
else
    echo "starting wiping"
    SIZ=$(stat -c%s $sourcefile)
    raw=0
    while (($raw < 50)); do
        clear
        echo "srm (secure-delete) not found."
        echo "I'm going to use an alternative script"
        echo
        echo "Wiping $sourcefile, it will be a clean job"
        echo "$raw of 50 passes done"
        dd if=/dev/urandom of=$sourcefile bs=$SIZ count=1
        raw=$(($raw+1))
    done
    echo "-----------------------------------------"
    echo "overwrite done!"
    echo "deleting file"
    rm $sourcefile

fi



dialog --title "Yatta!!!" --clear \
       --msgbox "File $sourcefile successfully wiped.\nHave a nice and secure day!\nyou have used TCCF by Giovanni Santostefano" 20 50
clear
