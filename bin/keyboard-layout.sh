#!/usr/bin/env bash

LANG=$(osascript -e 'tell application "System Events" to tell process "SystemUIServer" to get the value of the first menu bar item of menu bar 1 whose description is "text input"')

echo $LANG

#FANSPEED=$(sudo powermetrics -i 200 -n1 --samplers smc | grep "Fan" | sed 's/Fan: //g')

#echo $FANSPEED

#defaults read /Library/Preferences/com.apple.HIToolbox.plist  AppleEnabledInputSources | egrep -w "KeyboardLayout Name" | cut -c 34- | rev | cut -c 3- | rev
