#!/usr/bin/env bash

# Set Session Name
SESSION=$USER

tmux -2 new-session -d -s $SESSION -n 'Main'
tmux new-window -t $session:2 -n 'Alarms'
tmux send-keys "python3 ~/Desktop/Bash/ScrapeTest.py" C-m
tmux new-window -t $session:3 -n 'zsh'
tmux select-window -t $session:1

tmux split-window -h
tmux split-window -v

tmux select-pane -t 0
tmux split-window -v

tmux resize-pane -L 17
tmux resize-pane -D 1 

tmux select-pane -t 3
tmux resize-pane -U 15

#############
#   #   2   #
# 0 #########
#   #       #
#####   3   #
# 1 #       #
#############


tmux select-pane -t 2
tmux send-keys "htop" C-m

tmux select-pane -t 0
tmux send-keys "cd ~/Desktop/Academics/StickyNotes" C-m
rm -rf ~/Desktop/StickyNotes/.*swp
tmux send-keys "nvim -p *.txt" C-m

tmux select-pane -t 3
tmux send-keys "spt" C-m

tmux select-pane -t 1
tmux send-keys "echo jjjjjllllllll | ttyclock"

osascript -e 'display notification "Start Menu Launched" with title "Startmenu" sound name "Alert"'

tmux -2 attach-session -t $SESSION

pkill spotifyd
tmux kill-server