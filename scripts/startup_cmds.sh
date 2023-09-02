# #!/bin/bash
#
# # startup_cmds.sh
#
# c="$(hostname)"
# c="${c:0:1}"
#
# # daemons {{{
# start_daemon() {
#     if ! command -v "$1" > /dev/null ; then
#         echo "$1 not installed"
#         return
#     fi
#
#     local output
#
#     if ! pgrep -x "$1" ; then
#         $1 &
#         output="$1 started"
#     else
#         output="$1 already running"
#     fi
#
#     echo "$output"
# }
#
# for dae in $(sed -e '/^#/ d' ~/.dots/scripts/daemons.txt); do
#     start_daemon "$dae"
# done
# # }}}
#
# # run scripts or commands {{{
# if [[ -f "/home/chris/.dots/wall_${c}/wallpaper" ]]; then
#     feh --bg-scale "/home/chris/.dots/wall_${c}/wallpaper"
# fi
#
# # if [[ -x ~/.dots/scripts/run_polybar.sh ]]; then
# #     ~/.dots/scripts/run_polybar.sh
# # fi
# # }}}
#
# # if ping -c 1 8.8.8.8 &>/dev/null \
# #     && [[ -e ~/.dots/scripts/updates.sh ]]; then
# #     ~/.dots/scripts/updates.sh
# # fi
# #
# # if [[ -x ~/.dots/scripts/run_polybar.sh ]]; then
# #     /home/chris/.dots/scripts/run_polybar.sh
# # fi
# # }}}
#
# # vim: set filetype=sh foldmethod=marker:
