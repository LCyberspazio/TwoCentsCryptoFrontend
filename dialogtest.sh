#!/bin/bash

#encryption strength choice
dialog --clear --title "Cypher" \
        --menu "Choose your favorite cypher" 20 51 4 \
        "AES"  "Low Security/Fast" \
        "TwoFish" "Good Security/Slow" \
        "Serpent"  "High Security/Very Slow" 2> /tmp/tccf.cryptdevice.temp.wakawaka
retval=$?
cypher=$(cat /tmp/tccf.cryptdevice.temp.wakawaka)
rm /tmp/tccf.cryptdevice.temp.wakawaka

case $retval in
  0)
    echo "'$cypher' is your favorite cypher";;
  1)
    echo "Cancel pressed."
    exit 0;;
  255)
    echo "ESC pressed."
    exit 0;;
esac
