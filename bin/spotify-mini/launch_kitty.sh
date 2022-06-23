#!/usr/bin/env bash

/Applications/kitty.app/Contents/MacOS/kitty --single-instance ~/bin/spotify-mini/sptmini.sh

sleep .5

yabai -m window --toggle float
yabai -m window --move abs:1410:100
yabai -m window --resize abs:450:600
