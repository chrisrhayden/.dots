#!/bin/bash

if [[ -f ${HOME}/.dots/scripts/config_vars.sh ]]; then
    source "${HOME}/.dots/scripts/config_vars.sh"
else
    echo 'pleas set env colors'
    exit 1
fi

notify_send() {
    if hash notify-send; then
        notify-send "$1"
    fi
}

screen=" screen"
# this is weirdly hard to do
# window=" window"
area=" area"

# Launch Rofi
choose="$(
rofi -no-lazy-grab -sep "|" -dmenu -i -p 'Screen shot :' \
    -hide-scrollbar true \
    -bw 0 \
    -lines 4 \
    -line-padding 10 \
    -padding 20 \
    -width 15 \
    -location 7 \
    -xoffset "$CONFIG_ROFI_X_OFFSET" \
    -yoffset -"$CONFIG_ROFI_Y_OFFSET" \
    -columns 1 \
    -show-icons -icon-theme "Papirus" \
    -font "Fantasque Sans Mono 10" \
    -color-enabled true \
    -color-window "$CONFIG_ROFI_WINDOW" \
    -color-normal "$CONFIG_ROFI_NORMAL" \
    -color-active "$CONFIG_ROFI_ACTIVE" \
    -color-urgent "$CONFIG_ROFI_URGENT" \
<<< "$screen|$area")"

file_location="${HOME}/Pictures/screenshots"
mkdir -p "$file_location" 2>/dev/null
file_name="${file_location}/screenshot_$(date +'%F_%T').png"

case $choose in
    "$screen")
        sleep 1
        maim "$file_name"
        notify_send "screen shot saved to $file_name"
        ;;
    "$area")
        maim -s "$file_name"
        notify_send "screen shot saved to $file_name"
        ;;
esac
