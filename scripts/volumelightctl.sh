#!/bin/bash

SINK="@DEFAULT_AUDIO_SINK@"
SOURCE="@DEFAULT_AUDIO_SOURCE@"
STEP="5%"

notify_user() {
	notify-send \
        -t 2000 \
        -h string:x-canonical-private-synchronous:sys-notify \
        -u low \
        "$1"
}

notify_volume() {
    volume_status=$(wpctl get-volume $SINK)
    volume_percent=$(awk '{print int($2 * 100)}' <<< "$volume_status")

    if [[ $volume_status == *"[MUTED]"* ]]; then
        notify_user "Volume: ${volume_percent}% [MUTED]"
    else
        notify_user "Volume: ${volume_percent}%"
    fi
}

notify_mic() {
    mic_status=$(wpctl get-volume $SOURCE)
    mic_percent=$(awk '{print int($2 * 100)}' <<< "$mic_status")

    if [[ $mic_status == *"[MUTED]"* ]]; then
        notify_user "Microphone: ${mic_percent}% [MUTED]"
    else
        notify_user "Microphone: ${mic_percent}%"
    fi
}

notify_brightness() {
    notify_user "Brightness: $(brightnessctl -P get)"
}

case $1 in
    "--volume-inc")    wpctl set-volume $SINK $STEP+ && notify_volume ;;
    "--volume-dec")    wpctl set-volume $SINK $STEP- && notify_volume ;;
    "--volume-toggle") wpctl set-mute   $SINK toggle && notify_volume ;;

    "--mic-inc")     wpctl set-volume $SOURCE $STEP+ && notify_mic ;;
    "--mic-dec")     wpctl set-volume $SOURCE $STEP- && notify_mic ;;
    "--mic-toggle")  wpctl set-mute   $SOURCE toggle && notify_mic ;;

    "--brightness-inc") brightnessctl s $STEP+ && notify_brightness ;;
    "--brightness-dec") brightnessctl s $STEP- && notify_brightness ;;

    *) echo "Usage: ./volume_brightness.sh --[volume|mic|brightness]-[inc|dec|toggle]"
esac
