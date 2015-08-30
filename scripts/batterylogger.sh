#!/bin/sh

LOGFILE="/home/h0wser/battery.log"
INTERVALL="300" # in seconds

while true; do
	
	echo "$(date) - $(battery)" >> $LOGFILE
	sleep $INTERVALL
done
