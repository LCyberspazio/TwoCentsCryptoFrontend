#! /bin/bash

#
#Two Cents Crypto Frontend - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Developer: Giovanni Santostefano <giovannisantostefano@email.it>
# Contributor: Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>


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
#Public key displayer
gpg -k > ~/tccf.cryptdevice.temp.wakawaka
fold -w 70 -s ~/tccf.cryptdevice.temp.wakawaka > ~/tccf.cryptdevice.temp.wakawaka1
dialog --title "Public Address Book" --textbox ~/tccf.cryptdevice.temp.wakawaka1 22 70
rm ~/tccf.cryptdevice.temp.wakawaka
rm ~/tccf.cryptdevice.temp.wakawaka1
