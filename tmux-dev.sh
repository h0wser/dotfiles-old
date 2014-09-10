#!/bin/sh

# Will open a tmux session with the stuff i use while developing

# 3 panes one big with vim and 2 smaller with a command prompt for compiling and stuff
tmux new-session -d -n 'CODE' 'vim' 
tmux split-window -h 
tmux send-keys c Enter
tmux split-window -v 
tmux send-keys c Enter

# A window for other things that aren't very important
tmux new-window -n 'MISC'
tmux send-keys c Enter

tmux select-window -t "CODE"
tmux -2 attach-session 
