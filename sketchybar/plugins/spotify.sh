#!/usr/bin/env sh

# osascript -e 'display notification "Lorem ipsum dolor sit amet" with title "Alert"'

clip() {
  local input="$1"
  local max_length=35
  
  if [ "${#input}" -gt "$max_length" ]; then
    echo "${input:0:$((max_length-3))}..."
  else
    echo "$input"
  fi
}

RUNNING=$(osascript -e 'if application "Spotify" is running then return 0')
if [ "$RUNNING" == "" ]; then
  RUNNING=1
fi
PLAYING=1
TRACK=""
ALBUM=""
ARTIST=""
if [ "$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to get player state')" == "playing" ]; then
  PLAYING=0
  TRACK=$(osascript -e 'tell application "Spotify" to get name of current track')
  TRACK=$(clip "$TRACK")
  ARTIST=$(osascript -e 'tell application "Spotify" to get artist of current track')
  ALBUM=$(osascript -e 'tell application "Spotify" to get album of current track')
fi
if [ $RUNNING -eq 0 ] && [ $PLAYING -eq 0 ]; then
  if [ "$ARTIST" == "" ]; then
    sketchybar --set $NAME label=" $TRACK - $ALBUM" --set '/spotify.*/' drawing=on
  else
    sketchybar --set $NAME label=" $TRACK - $ARTIST" --set '/spotify.*/' drawing=on
  fi
else
  sketchybar --set $NAME label="" --set '/spotify.*/' drawing=on
fi
