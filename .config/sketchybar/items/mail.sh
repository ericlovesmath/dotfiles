#!/usr/bin/env sh

sketchybar --add item mail left                   \
           --set mail update_freq=120              \
                      script="$PLUGIN_DIR/mail.sh" \
                      icon.padding_left=22               \
                      icon.font="$ICON_FONT:Solid:16.0"  \
                      icon=$MAIL                   \
                      icon.color=$BLUE             \
                      label=!
