# set up user env by sourcing xsession if it exists
[[ -f ~/.xsession ]] && source ~/.xsession

exec i3

# vim: filetype=sh
