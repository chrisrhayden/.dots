xinput set-prop 'Clearly Superior Technologies. CST Laser Trackball' 'libinput Accel Speed' -0.9

setxkbmap -option caps:escape

if [[ -f ~/.xbindkeysrc ]]; then
    xbindkeys
fi

exec i3
