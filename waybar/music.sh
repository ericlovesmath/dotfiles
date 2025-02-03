#!/bin/sh

PLAYER_STATUS=$(playerctl -p spotify status 2> /dev/null)

if [ "$PLAYER_STATUS" = "Playing" ]; then
    ARTIST=$(playerctl metadata artist | sed 's/&/&amp;/g')
    TITLE=$(playerctl metadata title | sed 's/&/&amp;/g')
    echo "$ARTIST - $TITLE"
fi
