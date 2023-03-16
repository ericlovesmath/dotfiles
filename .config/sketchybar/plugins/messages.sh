#!/usr/bin/env sh
source "$HOME/.config/sketchybar/icons.sh"

RUNNING=$(osascript -e 'if application "Messages" is running then return 0')
COUNT=0

if [ "$RUNNING" = "0" ]; then
  COUNT=$(sqlite3 ~/Library/Messages/chat.db "SELECT text FROM message WHERE is_read=0 AND is_from_me=0 AND text!='' AND date_read=0" | wc -l)
  COUNT=$(echo $COUNT | xargs)
  if [ "$COUNT" -gt "0" ]; then
    sketchybar --set $NAME label="$COUNT" icon=$MESSAGE drawing=on
  else
    sketchybar --set $NAME drawing=off
  fi
else
  sketchybar --set $NAME label="!" icon=$MAIL
fi

