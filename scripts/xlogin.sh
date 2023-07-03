# check if graphical mode is available,
# if so check if the display is inactive
# and we are on virtual terminal 1

#if systemctl -q is-active graphical.target \
#    && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#
#    # start the xorg server
#    exec startx
#fi
#if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#    # start the xorg server
#    exec startx
#fi
