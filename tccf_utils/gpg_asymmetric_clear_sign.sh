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
dialog --title "File Digital ClearSigning" --clear \
       --msgbox "Attach a digital sign to a message" 10 50


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

############ CUT'N PASTE VERSION
sourcefile=~/tccf.cryptdevice.temp.wakawaka

dialog --title "File Digital ClearSigning" --clear \
       --msgbox "A nano text editor will open\nInsert or paste the text and hit\nCTRL+O to save\nCTRL+X to exit." 10 50

nano $sourcefile


############ FILE VERSION
##clear
##enter the filename
##sourcefile=`dialog --stdout --title "Select the file to sign" --fselect $HOME/ 14 58`
##
##case $? in
##	0)
##		echo "\"$sourcefile\" chosen";;
##	1)
##		echo "Cancel pressed."
##        exit 0;;
##	255)
##		echo "Box closed."
##        exit 0;;
##esac

clear
echo "Signing..."
gpg --clearsign $sourcefile

echo 
echo
dialog --title "Message Signed!" --clear \
       --msgbox "Next the signed message will be shown. Copy it" 15 60

clear
echo "-----------------------------------------------------------------"   
echo
echo
echo    
cat $sourcefile.asc
echo
echo
echo "Copy the message, then hit enter"
read
rm $sourcefile
rm $sourcefile.asc


