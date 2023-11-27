#!/bin/sh
#
# xinput set-prop 'Clearly Superior Technologies. CST Laser Trackball' 'libinput Accel Speed' -0.9
#
# setxkbmap -option caps:escape
#
# if [[ -f ~/.xbindkeysrc ]]; then
#     xbindkeys
# fi 
#
export XDG_SESSION_TYPE=X11

exec i3
