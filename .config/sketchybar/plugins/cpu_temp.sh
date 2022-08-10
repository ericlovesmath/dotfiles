#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

TEMP=$(osx-cpu-temp)
TEMP_INT=${TEMP::-2}

if ((TEMP_INT >= 80)); then
    ICON=""
	COLOR=$RED
elif ((TEMP_INT>= 70)); then
    ICON=""
	COLOR=$ORANGE
elif ((TEMP_INT>= 60)); then
    ICON=""
	COLOR=$YELLOW
else
    ICON=""
	COLOR=$GREEN
fi

sketchybar --set $NAME label="${TEMP}" icon.color="${COLOR}" icon="${ICON}"
