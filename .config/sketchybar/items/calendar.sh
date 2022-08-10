#!/usr/bin/env sh

sketchybar --add item     calendar right               \
           --set calendar update_freq=15               \
                          icon=cal                     \
                          icon.color=$BLACK            \
                          icon.font="$FONT:Bold:12.0" \
                          icon.padding_left=15         \
                          label.width=55               \
                          label.align=right            \
                          label.color=$BLACK           \
                          label.padding_right=15       \
                          align=center                 \
                          script="~/.config/sketchybar/plugins/time.sh" \
                          background.color=0xffb8c0e0  \
                          background.height=20         \
                          background.corner_radius=9
