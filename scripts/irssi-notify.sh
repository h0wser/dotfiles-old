#!/bin/bash

HOST="epsilon.dank"
USER="h0wser"
FIFO="/tmp/irssi-fifo"
NOTIFICATION_SOUND="/home/h0wser/audio/soundpack/audio/notifications/Subtle.mp3"

trap "rm -f $FIFO" EXIT

if [[ ! -p $FIFO ]]; then
	mkfifo $FIFO
fi

autossh -M -0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 2" $USER@$HOST "tail -F ~/.irssi/fnotify" >$FIFO &

while true; do
	if read LINE <$FIFO; then
		SUMMARY="$(echo $LINE | awk '{print $2}')"
		BODY="$(echo $LINE | cut -d " " -f 3- | sed 's/:> h0wser:/:/g')"
		play -q "$NOTIFICATION_SOUND" &
		notify-send -c irc "$SUMMARY" "$BODY"
	fi
done

wait
