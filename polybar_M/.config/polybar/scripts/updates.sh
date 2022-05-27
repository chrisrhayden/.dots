#!/usr/bin/env bash

UPDATES=
BAR_ICON=""
NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

get_total_updates() { UPDATES=$(checkupdates 2>/dev/null | wc -l); }

get_total_updates


if (( UPDATES == 1 )); then
    echo "$BAR_ICON $UPDATES"
elif (( UPDATES > 1 )); then
    echo "$BAR_ICON $UPDATES"
else
    echo "$BAR_ICON $(date)"
fi
