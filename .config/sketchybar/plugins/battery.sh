#!/bin/bash

CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ ${CHARGING} != "" ]]; then
	sketchybar --set $NAME icon="" label="${BATT_PERCENT}%"
	exit 0
fi

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

if ((BATT_PERCENT >= 75)); then
	ICON=""
elif ((BATT_PERCENT >= 50)); then
	ICON=""
elif ((BATT_PERCENT >= 25)); then
	ICON=""
else
    ICON=""
fi

sketchybar --set $NAME icon="${ICON}" label="${BATT_PERCENT}%"
