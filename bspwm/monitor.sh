#!/bin/bash

if [[ $(bspc query -M | wc -l) == 2 ]]
then
	bspc monitor ^0 -n "main" -d "main" "web" "term" "im" "misc"
	bspc monitor ^1 -n "laptop" -d "main" "web" "term" "im" "misc"

	bspc config -m 0 window_gap 40
	bspc config -m 0 top_padding 26
	bspc config -m 1 top_padding 0
else
	bspc monitor -d "main" "web" "term" "im" "misc"

	bspc config -m 0 window_gap 40
	bspc config -m 0 top_padding 26
fi
