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
dialog --title "Digital Sign verification" --clear \
       --msgbox "Verify the authenticity of a file with his <detached> digital signature" 10 50


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
sigfile=`dialog --stdout --title "Select the signature file" --fselect $HOME/ 14 58`

case $? in
	0)
		echo "\"$sigfile\" chosen";;
	1)
		echo "Cancel pressed."
        exit 0;;
	255)
		echo "Box closed."
        exit 0;;
esac

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

#enter the filename
basefile=`dialog --stdout --title "Select the original file" --fselect $HOME/ 14 58`

case $? in
	0)
		echo "\"$basefile\" chosen";;
	1)
		echo "Cancel pressed."
        exit 0;;
	255)
		echo "Box closed."
        exit 0;;
esac

if [ -e "$basefile" ]
then
  echo "original file taken!"
else
  echo
  echo
  echo "ERROR!!!"
  echo "original file not found!"
  exit 4
fi



clear
echo "Verifying..."
gpg --verify $sigfile $basefile 2> ~/tccf.cryptdevice.temp.wakawaka
fold -w 70 -s ~/tccf.cryptdevice.temp.wakawaka > ~/tccf.cryptdevice.temp.wakawaka1
dialog --title "Signature results" --textbox ~/tccf.cryptdevice.temp.wakawaka1 22 70
rm ~/tccf.cryptdevice.temp.wakawaka
rm ~/tccf.cryptdevice.temp.wakawaka1

echo 
echo
dialog --title "GOOD BYE!" --clear \
       --msgbox "thanks for using TCCF by Giovanni Santostefano" 15 60
