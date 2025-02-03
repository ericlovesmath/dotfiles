#!/bin/bash

# get_icon() {
# 	current=$(get_volume)
# 	if [[ "$current" -eq "0" ]]; then
# 		echo "$iDIR/volume-mute.png"
# 	elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
# 		echo "$iDIR/volume-low.png"
# 	elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
# 		echo "$iDIR/volume-mid.png"
# 	elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
# 		echo "$iDIR/volume-high.png"
# 	fi
# }

notify_user() {
	notify-send \
        -t 2000 \
        -h string:x-canonical-private-synchronous:sys-notify \
        -u low \
        "$1"
}

notify_volume() {
    notify_user "Volume: $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')"
}

notify_brightness() {
    notify_user "Brightness: $(brightnessctl -P get)"
}

if [[ "$1" == "--volume-inc" ]]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && notify_volume
elif [[ "$1" == "--volume-dec" ]]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify_volume
elif [[ "$1" == "--volume-toggle" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify_volume
elif [[ "$1" == "--brightness-inc" ]]; then
    brightnessctl s 5%+ && notify_brightness
elif [[ "$1" == "--brightness-dec" ]]; then
    brightnessctl s 5%- && notify_brightness
# elif [[ "$1" == "--mic-toggle" ]]; then
# elif [[ "$1" == "--mic-inc" ]]; then
# elif [[ "$1" == "--mic-dec" ]]; then
fi
