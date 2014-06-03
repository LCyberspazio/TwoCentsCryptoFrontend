#! /bin/bash

#
#Two Cents Crypto Frontend 0.1 - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Two Cents Crypto Frontend 0.2 - 2014 Software edited and modified by Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>


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
dialog --title "PRIVATE KEYS" --clear \
   --msgbox "`gpg -K 2>&1`" 30 80
