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
 
nvidia-settings --load-config-only

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Turns off system beep.. don't like that thing..
xset b off
xset b 0 0 0 

# awesome window manager
# Not sure if the --no-argb arg is helping or not..
# It's used to prevent screen tearing
compton &
exec awesome --no-argb

# exec startxfce4
