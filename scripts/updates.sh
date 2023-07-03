#!/usr/bin/env bash

# the update script is from this persons repo
# https://github.com/adi1090x/polybar-themes

if ! command -v checkupdates > /dev/null; then
    exit
fi


ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg
UPDATES=$(checkupdates 2>/dev/null | wc -l)

# notify user of updates
if command -v notify-send > /dev/null; then
    if (( $UPDATES > 100 )); then
        notify-send -u critical -i "$ICON" \
            "You really need to update!!" "$UPDATES New packages"
    elif (( $UPDATES > 50 )); then
        notify-send -u normal -i "$ICON" \
            "You should update soon" "$UPDATES New packages"
    elif (( $UPDATES > 1 )); then
        notify-send -u normal -i "$ICON" "$UPDATES New packages"
    else
        notify-send -u low -i "$ICON" 'no updates'
    fi
fi
