#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

TEMP=$(smctemp -c)
TEMP_INT=$(echo "$TEMP" | cut -c -2)

if ((TEMP_INT >= 70)); then
	ICON=""
	COLOR=$RED
elif ((TEMP_INT >= 60)); then
	ICON=""
	COLOR=$ORANGE
elif ((TEMP_INT >= 50)); then
	ICON=""
	COLOR=$YELLOW
else
	ICON=""
	COLOR=$GREEN
fi

sketchybar --set $NAME label="${TEMP}" icon.color="${COLOR}" icon="${ICON}"
