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


rofi_menu=''

daemons=( $(sed -e '/^#/ d' ~/.dots/scripts/daemons.txt) )

for da in ${daemons[@]}; do
    if pgrep -x "$da" &>/dev/null ; then
        rofi_menu+=" ${da}|"
    else
        rofi_menu+=" ${da}|"
    fi
done

# remove the trailing | from the menu string
rofi_menu="${rofi_menu%|}"

# # Launch Rofi
choose="$(
rofi -no-lazy-grab -sep "|" -dmenu -i -p 'Daemons :' \
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
<<< "$rofi_menu"
)"

# get just the daemon cmd from the menu string
daemon_cmd="${choose##* }"

if [[ $choose == * ]]; then
    notify_send "stopping $daemon_cmd"
    pkill "$daemon_cmd"

elif [[ $choose == * ]]; then
    notify_send "starting $daemon_cmd"
    $daemon_cmd &>/dev/null &
fi
