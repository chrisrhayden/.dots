#!/bin/bash

# run polybar, mostly for testing

# Terminate already running bar instances
killall -q polybar &>/dev/null

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar &>/dev/null; do
    sleep 1
done

# Launch bar1 and bar2
polybar -c ~/.config/polybar/config.ini main &
polybar -c ~/.config/polybar/config.ini secondary &
