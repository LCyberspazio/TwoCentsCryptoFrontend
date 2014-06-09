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

############ CUT'N PASTE VERSION
sigfile=~/tccf.cryptdevice.temp.wakawaka

dialog --title "Digital ClearSigning verification" --clear \
       --msgbox "A nano text editor will open\nInsert or paste the signed text and hit\nCTRL+O to save\nCTRL+X to exit.\n\nWARNING: Don't put new lines at the end of the signed message!!!" 10 80


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

############ FILE VERSION
##clear
###enter the filename
##sigfile=`dialog --stdout --title "Select the signature file" --fselect $HOME/ 14 58`

##case $? in
##	0)
##		echo "\"$sigfile\" chosen";;
##	1)
##		echo "Cancel pressed."
##        exit 0;;
##	255)
##		echo "Box closed."
##        exit 0;;
##esac
##

nano $sigfile


if [ -e "$sigfile" ]
then
  echo "signature taken!"
else
  echo
  echo
  echo "ERROR!!!"
  echo "signature not found!"
  exit 3
fi

clear
echo "Verifying..."
gpg --verify $sigfile 2> ~/tccf.cryptdevice.temp.wakawaka2
fold -w 70 -s ~/tccf.cryptdevice.temp.wakawaka2 > ~/tccf.cryptdevice.temp.wakawaka1
dialog --title "Signature results" --textbox ~/tccf.cryptdevice.temp.wakawaka1 22 70
rm ~/tccf.cryptdevice.temp.wakawaka
rm ~/tccf.cryptdevice.temp.wakawaka1
rm ~/tccf.cryptdevice.temp.wakawaka2

echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "thanks for using TCCF by Giovanni Santostefano" 15 60
