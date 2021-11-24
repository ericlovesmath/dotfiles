#!/usr/bin/env bash

if ! pgrep -x "Spotify|spotifyd" > /dev/null; then
    echo "Spotify Device not found, launching spotifyd..."
    spotifyd
fi

case $1 in  
    h|help)
        echo "Help";;
    p|play)
        echo "Toggling Play / Pause"
        spt playback --toggle;;
    "")
        echo "Playing Liked Songs in Shuffle..."
        spt play --playlist --random --name Liked

        STATUS=$(spt playback --status -f "%f %s")
        if [[ ! $STATUS =~ "[Shuffle]" ]]; then
            spt playback --shuffle
        fi;;
    *)
        echo "Invalid";;
esac > /dev/null

spt playback --status -f "%t - %a // %f %s"

: '
spotifyd
spt play --playlist --name Liked
spt playback --next --previous --repeat --toggle --status --etc

spt playback --status -f "%f %s %t - %a"
	a: Taylor Swift 
	b: evermore (deluxe version) 
	d: Eric-MBP 
	f: [Shuffle] [Repeat] ♥ 
	r: 2:42/4:05 (-1:22) 
	s: ▶ 
	t: right where you left me - bonus track 
	u: spotify:track:3zwMVvkBe2qIKDObWgXw4N 
	v: 100 

behavior:
  liked_icon: ♥
  shuffle_icon: "[Shuffle]"
  repeat_track_icon: "[Solo]"
  repeat_context_icon: "[Repeat]"
  playing_icon: ▶
  paused_icon: ■

Use FZF?
Dots add this and config.yml
'
