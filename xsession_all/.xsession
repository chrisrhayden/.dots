# setup monitors
xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0

# remap caps lock to escape
setxkbmap -option caps:escape

xrdb -merge $HOME/.Xresources

if [[ -f ${HOME}/.xbindkeysrc ]]; then
    xbindkeys
fi

if [[ -f ${HOME}/.Xmodmap ]]; then
    xmodmap ~/.Xmodmap
fi

# turn off th bell
xset b off
