#!/usr/bin/env bash

script='tell application "iTerm2"
    set newWindow to (create window with default profile)
    tell current session of newWindow
        write text "~/bin/spotify_mini/sptmini.sh"
    end tell
end tell'
! osascript -e "${script}" > /dev/null 2>&1 && {
    # Get pids for any app with "iTerm" and kill
    while IFS="" read -r pid; do
        kill -15 "${pid}"
    done < <(pgrep -f "iTerm")
    open -a "/Applications/iTerm.app"
}

yabai -m window --toggle float
yabai -m window --move abs:1410:100
yabai -m window --resize abs:450:570
