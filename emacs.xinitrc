# Disable access control
xhost +SI:localuser:$USER

# set keymap to SWEDISH KEYBOARD
setxkbmap se

# Themes, etc
#gnome-settings-daemon &

# Fallback cursor
xsetroot -cursor_name left_ptr

# Keyboard repeat rate
xset r rate 200 60

xset +fp /usr/share/fonts/local/
xset fp rehash

sxhkd -f 100&

# laptop touchpad
synclient AccelFactor=0
synclient MaxSpeed=4
synclient MinSpeed=2
synclient PalmDetect=1
synclient PalmMinWidth=5

redshift&

xrdb -m ~/.Xresources

lemonbuddy_wrapper top &

# Start Emacs
exec dbus-launch --exit-with-session emacs
