#!/bin/bash

# startup_cmds.sh

# daemons {{{
start_daemon() {
    if ! pgrep -x "$1" && hash "$1" ; then
        "$1" &
        printf '%s started for the first time\n' "$1"
    else
        printf '%s already running \n' "$1"
    fi
}

for dae in $(sed -e '/^#/ d' ~/.dots/scripts/daemons.txt); do
    start_daemon "$dae"
done
# }}}

# run scripts or commands {{{
[[ -f '/home/chris/.themes/wall/wallpaper' ]] && \
    feh --bg-scale '/home/chris/.themes/wall/wallpaper'

[[ -x ~/.dots/scripts/run_polybar.sh ]] && \
    ~/.dots/scripts/run_polybar.sh
# }}}

if ping -c 1 8.8.8.8 &>/dev/null \
    && [[ -e ~/.dots/scripts/updates.sh ]]; then
    ~/.dots/scripts/updates.sh
fi

# vim: set filetype=sh foldmethod=marker:
