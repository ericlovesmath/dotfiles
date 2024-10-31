#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

COLOR=$YELLOW
if ((BATT_PERCENT >= 75)); then
	ICON=""
elif ((BATT_PERCENT >= 50)); then
	ICON=""
elif ((BATT_PERCENT >= 25)); then
	ICON=""
else
	COLOR=$RED
    ICON=""
fi

CHARGING=$(pmset -g batt | grep 'AC Power')
if [[ ${CHARGING} != "" ]]; then
	ICON=""
fi

sketchybar --set $NAME icon="${ICON}" label="${BATT_PERCENT}%" icon.color="${COLOR}"
