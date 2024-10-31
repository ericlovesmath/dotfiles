#!/usr/bin/env sh

sketchybar --add item  messages left                          \
           --subscribe messages system_woke                   \
           --set       messages update_freq=15                \
                       updates=on                             \
                       script="$PLUGIN_DIR/messages.sh"       \
                       click_script="$PLUGIN_DIR/messages.sh" \
                       icon.padding_left=22                   \
                       background.padding_right=-15           \
                       icon.font="$ICON_FONT:Solid:16.0"      \
                       icon=$MESSAGE                          \
                       icon.color=$GREEN                      \
                       label=!

