#!/usr/bin/env sh

sketchybar --add item battery right                   \
           --set battery update_freq=120              \
                      script="$PLUGIN_DIR/battery.sh" \
                      background.padding_left=5  \
                      icon.font="$ICON_FONT:Solid:14.0"  \
                      icon=                   \
                      icon.color=$YELLOW             \
                      label=!
