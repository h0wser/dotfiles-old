#!/bin/bash

nr_of_desktops=$(bspc query -D | wc -l)
nr_of_monitors=$(bspc query -M | wc -l)
selected_monitor=$(bspc query -M -m focused)

if [[ $nr_of_monitors == 1 ]] || [[ $3 == "override" ]]
then
	desktop=$1
else
	if [[ $selected_monitor == "laptop" ]]
	then
		desktop=$1
	else 
		desktop=$(($1 + $nr_of_desktops/2))
	fi
fi

if [[ $2 == "switch" ]]
then
	bspc desktop -f ^$desktop
elif [[ $2 == "send" ]]
then
	bspc window -d ^$desktop
fi
