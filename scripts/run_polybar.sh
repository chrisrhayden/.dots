#!/bin/bash

echo "killing polybar"
killall -q polybar &>/dev/null

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do
    echo "waiting for polybar to shut down"
    sleep 1
done

echo "launching polybar"
polybar -c ~/.config/polybar/config.ini main &
polybar -c ~/.config/polybar/config.ini secondary &
