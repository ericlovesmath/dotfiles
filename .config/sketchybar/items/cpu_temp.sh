#!/usr/bin/env sh

sketchybar --add item cpu_temp right                   \
           --set cpu_temp update_freq=20              \
                      script="$PLUGIN_DIR/cpu_temp.sh" \
                      background.padding_left=5  \
                      icon.font="$ICON_FONT:Solid:14.0"  \
                      icon=                         \
                      icon.color=$ORANGE             \
                      # label=!
