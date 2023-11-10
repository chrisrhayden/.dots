[[ $- != *i* ]] && return

# https://wiki.archlinux.org/title/Fish#Setting_fish_as_default_shell
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" \
    && -z ${BASH_EXECUTION_STRING} ]]; then
    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
    exec fish $LOGIN_OPTION
fi
