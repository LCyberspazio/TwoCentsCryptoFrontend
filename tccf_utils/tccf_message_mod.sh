#! /bin/bash

#
#Two Cents Crypto Frontend - Copyright (C) 2014 Giovanni Santostefano
#This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type `show c' for details.
#
# Developer: Giovanni Santostefano <giovannisantostefano@email.it>
# Contributor: Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>

#encryption strength choice
while :
do
dialog --clear --title "Encrypted Messaging module" \
        --menu "Choose your activity" 10 60 3 \
        "Encrypt"  "Encrypt short text AES" \
        "Decrypt" "Decrypt short text AES" \
        "Otp"     "Generate a One Time Pad" 2> /tmp/tccf.cryptdevice.temp.wakawaka
retval=$?
action=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    if [[ $action =~ "Encrypt" ]]
    then
	clear
	dialog --title "Encrypt Text messages" --clear \
		--msgbox "Write simple messages and encrypt with AES.\nPassword is shown in clear, use only on your private systems" 10 50
        clear
        echo -n "INSERT PASSWORD: "
        read -s pass
        echo 
        echo
        while :
	do
		echo "Write the message and press [CTRL+D] to encrypt"
		gpg --symmetric --armor --passphrase $pass 2> /dev/null
		echo
	done
    elif [[ $action =~ "Decrypt" ]]
    then
	clear
	dialog --title "Decrypt Text messages" --clear \
		--msgbox "Decrypt simple messages with AES.\nPassword is shown in clear, use only on your private systems" 10 50
        clear
        echo -n "INSERT PASSWORD: "
        read -s pass
        echo
        echo
        while :
	do
		echo "Write the message and press [CTRL+D] to decrypt"
		gpg -d --passphrase $pass 2> /dev/null
		echo
	done
    elif [[ $action =~ "Otp" ]]
    then
	clear
	dialog --title "One time pad generator" --clear \
		--msgbox "Exchange this OTP with your contact and use a one time pass for each conversation" 10 50
        clear
        c=0
        echo "+==ONE TIME PAD==+"
        while [[ $c -lt 10 ]]
	do
		outp=$(dd if=/dev/urandom of=/dev/stdout bs=1 count=6 2> /dev/null | base64)
		echo "|    $outp    |"
		c=$c+1
	done
	echo "+----------------+"
	echo
	echo
	echo
	echo "PRESS ANY KEY TO CONTINUE"
	read
    else
        clear
        echo "eventually add..."
    fi
    echo "'$action'";;
  1)
    echo "Cancel pressed."
    #remember to launch back the top script
    exit 0;;
  255)
    echo "ESC pressed."
    exit 0;;
esac
done
