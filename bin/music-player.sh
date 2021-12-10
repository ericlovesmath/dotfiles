#!/usr/bin/env bash

if ! pgrep -x "Spotify|spotifyd" > /dev/null; then
    # echo "Spotify Device not found, launching spotifyd..."
    # spotifyd
    # Note: Spotifyd needs to be updated to librespot 2.0.0, currently low res
    open -j "/Applications/Spotify.app"
    sleep 1
fi

case $1 in  
    h|help)
        echo "Help";;
    s|start|stop)
        echo "Toggling Play / Pause"
        spt playback --toggle;;
    n|next)
        echo "Playing Next Song"
        spt playback --next;;
    p|prev|previous)
        echo "Playing Previous Song"
        spt playback --previous;;
    "")
        echo "Playing Liked Songs in Shuffle..."
        spt play --playlist --random --name "Liked Songs"
        sleep 1
        STATUS=$(spt playback --status -f "%f %s")
        if [[ ! $STATUS =~ "[Shuffle]" ]]; then
            spt playback --shuffle
        fi;;
esac > /dev/null

spt playback --status -f "%t - %a"
#spt playback --status -f "%r // %f %s"

# Notes
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
'
