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

xset r rate 200 60

xset +fp /usr/share/fonts/local/
xset fp rehash

sxhkd -f 100&

synclient AccelFactor=0
synclient MaxSpeed=4 
synclient MinSpeed=2
synclient PalmDetect=1
synclient PalmMinWidth=5

redshift -l 56.046467:12.694512 &
dunst&

eval $(cat ~/.fehbg)

envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
	eval "$(cat "$envfile")"
else
	eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
fi
export GPG_AGENT_INFO  # the env file does not contain the export statement
export SSH_AUTH_SOCK   # enable gpg-agent for ssh

exec herbstluftwm --locked
