#!/bin/bash

BATINFO0=`acpi -b | grep "Battery 0"`
BATINFO1=`acpi -b | grep "Battery 1"`
if [[ `echo $BATINFO1 | grep Discharging` && `echo $BATINFO1 | cut -f 5 -d " "` < 00:15:00 ]] ; then
    /usr/bin/notify-send --urgency critical "Low Battery"
fi
