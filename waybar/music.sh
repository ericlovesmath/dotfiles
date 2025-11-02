#!/bin/sh

PLAYER_STATUS=$(playerctl -p spotify status 2> /dev/null)

if [ "$PLAYER_STATUS" = "Playing" ]; then
    ARTIST=$(playerctl -p spotify metadata artist | sed 's/&/&amp;/g')
    TITLE=$(playerctl -p spotify metadata title | sed 's/&/&amp;/g')
    echo " $ARTIST - $TITLE"
fi
if [ "$PLAYER_STATUS" = "Paused" ]; then
    echo ""
fi
