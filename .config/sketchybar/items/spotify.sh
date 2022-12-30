#!/usr/bin/env sh

SPOTIFY_PLAY="osascript -e 'tell application \"Spotify\" to playpause'"
SPOTIFY_NEXT="osascript -e 'tell application \"Spotify\" to play next track'"
SPOTIFY_PREV="osascript -e 'tell application \"Spotify\" to play previous track'"
sketchybar --add     event     spotify_change "com.spotify.client.PlaybackStateChanged"

sketchybar --add     item           spotify_next right           \
           --set     spotify_next   label=""                    \
                                    icon.drawing=off                \
                                    click_script="$SPOTIFY_NEXT"

sketchybar --add        item      spotify right                   \
           --subscribe  spotify   spotify_change                  \
           --set        spotify   icon.drawing=off                \
                                  script="$PLUGIN_DIR/spotify.sh" \
                                  click_script="$SPOTIFY_PLAY"

sketchybar --add     item           spotify_prev right           \
           --set     spotify_prev   label=""                    \
                                    icon.drawing=off             \
                                    click_script="$SPOTIFY_PREV"
