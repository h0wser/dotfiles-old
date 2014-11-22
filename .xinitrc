#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# this is a huge hack to make icons from stlarch 
# display when we start X
export LANG=en_US.UTF8

# set keymap to SWEDISH KEYBOARD
setxkbmap se

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Turns off system beep.. don't like that thing..
xset b off
xset b 0 0 0 

xset +fp /usr/share/fonts/local/
xset fp rehash

xscreensaver -nosplash &
#exec awesome --no-argb

sxhkd -f 100&
compton &
eval $(cat ~/.fehbg)
mopidy -q --config ~/.confg/mopidy/ &

synclient AccelFactor=0
synclient MaxSpeed=4 
synclient MinSpeed=2
synclient PalmDetect=1
synclient PalmMinWidth=5

exec bspwm
