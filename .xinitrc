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

# set keymap to SWEDISH KEYBOARD
setxkbmap se

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Turns off system beep.. don't like that thing..
xset b off
xset b 0 0 0 

#xscreensaver -nosplash &
#exec awesome --no-argb

sxhkd -f 100&
compton &
feh --bg-fill ~/wallpaper.png
exec bspwm
