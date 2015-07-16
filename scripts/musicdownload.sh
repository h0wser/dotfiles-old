#!/bin/bash

# Downloads all likes and playlists from soundclound
# and then syncs them to phone at ip "$1"
# Need to have sshelper running on android phone

if [ -z "$1" ]
then
	echo "Usage: $0 <ip>"
	exit 1
fi

# add --silent to remove output
scdl -f
scdl -p

rsync -ruv -e 'ssh -p 2222' music/ $1:~/SDCard/Music
