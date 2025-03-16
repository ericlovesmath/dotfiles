#!/usr/bin/bash

cd $HOME/dotfiles/wallpapers

MONITORS=$(hyprctl monitors all | grep Monitor | cut -d ' ' -f 2 | tr '\n' ' ')

COUNT=$(echo $MONITORS | wc -w)

if [ $COUNT -eq 0 ]; then
    echo "Error: $(hyprctl monitors all)"
    exit; 
fi

for MONITOR in $MONITORS; do
    BG=$(find . -print | fzf --header "Setting $MONITOR")
    swww img -o "$MONITOR" $BG --transition-type center
    swww img -o "$MONITOR" $BG --transition-type center
    echo "Set $MONITOR to $BG"
done
