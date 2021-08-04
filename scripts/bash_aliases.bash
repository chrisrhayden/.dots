# alias for bash and zsh

# bash directory shortcuts {{{
BK='/mnt/backup'
BOK='/mnt/slowlinuxstorage/books'
DOT='/home/chris/.dots'
GAM='/mnt/linuxstorage/games'
LS='/mnt/linuxstorage'
MOV='/mnt/linuxstorage/movies'
MUS='/mnt/slowlinuxstorage/music'
SHO='/mnt/slowlinuxstorage/shows'
ANI='/mnt/slowlinuxstorage/anime'
SL='/mnt/slowlinuxstorage'
STE='/home/chris/.local/share/Steam/'
export BK BOK DOT GAM LS MOV MUS SHO SL STE
# }}}

# shadow commands {{{
alias ls='ls --color'
alias grep='grep --color'
alias diff='diff --color'

alias mv='mv --interactive'
alias rm='rm --interactive'
alias cp='cp --interactive'

alias fd='fd --hidden'
alias rg='rg --hidden --one-file-system'

alias df='df --human'
alias free='free --human'
alias xsel='xsel --clipboard'

alias dirs='dirs -v'

# alias ssh='TERM=xterm-color ssh'
alias tree='tree -C --filelimit 20'
alias gdb='gdb --quiet'
alias info='info --vi-keys'
alias lsblk='lsblk --output name,size,fstype,mountpoint'
alias bat='bat --paging never --style plain --wrap character --color auto'
alias ytop='ytop --per-cpu --minimal '
alias radeontop='radeontop  --color'
alias tty-clock='tty-clock -t -c -C 5'
alias unimatrix='unimatrix --character-list=k --speed=90'

alias navi='navi --print'

# TODO: dict / dictd should probably have a default dictionary or something
alias dict='dict --database wn'
# }}}

# shortcuts {{{
alias clock='tty-clock'
alias jj='journalctl'
alias py='python'
alias ipy='ipython'
alias job='jobs'
# dir is ls but with different options https://askubuntu.com/questions/103913/
alias dir='dirs'
alias zn='znotes'
# }}}

# typos {{{
alias sl='ls'
alias lk='ls'
alias vm='mv'
alias grp='grep'
alias gti='git'
alias vi='vim'
alias cim='vim'
alias mvp='mpv'
alias tuch='touch'
# }}}

# added commands or wrappers {{{
# system {{{
alias zsrc='source "${ZDOTDIR}/.zshrc"'

mktodir() { mkdir -p "$@" && cd "$@"; }

cdfzf() {
    if [[ $# -gt 1 ]]; then
        echo 'too may paths'
        return 0
    fi

    # TODO: something better
    find_args=(
        -path '*.git' -prune
        -o -path '*target/debug*' -prune
        -o -path '*target/release*' -prune
        -o -path '*target/doc*' -prune
        -o -path '*target/rls*' -prune
        -o -path '*node_modules*' -prune
        -o -type d
    )

    if [[ -n "$1" ]]; then
        find_out="$(find "$1" ${find_args[@]} -print)"
    else
        find_out="$(find . ${find_args[@]}  -print)"
    fi

    cd "$(echo "$find_out" | fzf)"
}


get_pacman_mirrors() {
    echo "WARNING very slow (sent to stderr)" 1>&2
    reflector --country us --fastest 20  --protocol https --sort rate
}
# }}}

to_lower() {
    tr '[:upper:]' '[:lower:]'
}

to_upper() {
    tr '[:lower:]' '[:upper:]'
}

clone_xsel() {
    if [[ -n "$1" ]]; then
        git clone "$(xsel)" "$1"
    else
        git clone "$(xsel)"
    fi
}

# misc {{{
today() {
    printf '\n%s\n%b%s%b\n' \
        "$(date +'%-l:%M%P')" \
        '\033[7m' "$(date +'%B %F')" '\033[0m'

    cal --color=always | cut -d$'\n' -f2-
}


bzathura() {
    # bash doesn't like a ; after the &
    zathura "$@" &
}

# add a udev rule if it doesn't work
# https://wiki.archlinux.org/index.php/Backlight#ACPI
brightness() {
    if [[ $1 =~ [0-9]+ ]]; then
        tee /sys/class/backlight/intel_backlight/brightness <<< "$1"
    else
        echo 'pleas give a number'
    fi
}

getvids() {
    youtube-dl -f best --restrict-filename --write-sub --yes-playlist \
        --output '/mnt/linuxstorage/shows/youtube/%(title)s_%(id)s.%(ext)s' "$@"
}
# }}}

# editor {{{
# set up config file aliases {{{
# TODO: there are so many ways this could be improved
{
    # get the current shell name, $$ is the current running proses
    CONFIG_SHELL="$(ps -p "$$" -o comm=)"

    # declare an associative array
    declare -A dot_files

    keys=''

    # this is kinda shitty, {ba,zs}sh doesn't export arrays of any
    # kind so we use an exported string space separated paths
    #   (e.g. "echo '"${HOME}/.config/i3/config" "${HOME}/.bashrc" ..  )
    export all_dot_files

    # a helper function, mostly for the `vim_dots` alias
    clean_dot_file_paths() {
        echo "${all_dot_files}" \
            | envsubst \
            | tr ' ' '\n' | tr -d ' ' | tr -d '"' | sed '/^$/d'
    }

    dot_files[brconf]='"${HOME}/.bashrc"'
    dot_files[baconf]='"${HOME}/.dots/scripts/bash_aliases.bash"'
    dot_files[zrconf]='"${HOME}/.zshrc.d/.zshrc"'
    # dot_files[nvconf]='"${HOME}/.config/nvim/init.vim"'
    dot_files[nvconf]='"${HOME}/.config/nvim/init.lua"'
    dot_files[alconf]='"${HOME}/.config/alacritty/alacritty.yml"'
    dot_files[teconf]='"${HOME}/.config/termite/config"'
    dot_files[bsconf]='"${HOME}/.config/bspwm/bspwmrc"'
    dot_files[sxconf]='"${HOME}/.config/sxhkd/sxhkdrc"'
    dot_files[poconf]='"${HOME}/.config/polybar/config.ini"'
    dot_files[i3conf]='"${HOME}/.config/i3/config"'
    dot_files[quconf]='"${HOME}/.config/qutebrowser/config.py"'

    if [[ $CONFIG_SHELL == zsh ]]; then
        setopt shwordsplit
        keys="${(k)dot_files}"

        all_dot_files="${(v)dot_files}"
    else
        keys="${!dot_files[@]}"

        all_dot_files="${dot_files[@]}"
    fi


    for key in $keys; do
        alias $key='$EDITOR '"${dot_files[$key]}"

        zlong_ignore_cmds+=$key' '
    done

    if [[ $CONFIG_SHELL == zsh ]]; then
        unsetopt shwordsplit
    fi

    alias vim_dots='clean_dot_file_paths \
        | vim \
            +"setlocal noswapfile" \
            +"setlocal buftype=nofile" \
            +"setlocal bufhidden=hide" \
            +"setlocal filetype=dirvish"'
}
# }}}

# vim cmds {{{
alias vpclean='vim +"PlugClean" +"qall"'
alias vpupdate='vim +"PlugUpdate" +"CocUpdate" +"qall"'
alias vpinstall='vim +"PlugInstall" +"qall"'

alias view='$EDITOR -R -u ${HOME}/.config/nvim/view_init.vim'
alias wim='$EDITOR -u "${HOME}/.config/nvim/writing_init.vim"'

vim_help() { vim +"help $1 | only"; }
# }}}

# }}}
# }}}

# extra not used much {{{

layout() {
    local line_color='\033[32m'
    local reset='\033[0m'

    printf '%b╓─────%b d i s k . u s a g e \n' \
        "${line_color}" "${reset}"
    printf '%b╙────────────────────────────────────── ─ ─ %b \n' \
        "${line_color}" "${reset}"

    df -h | cut -d$'\n' -f1
    df -h | grep '^/dev'  |  sort -k 6.1
}

tuxxx() {
# single quotes are being used so double are necessary
printf "
           .888888:.
           88888.888.
          .8888888888
          8' \`88' \`888
          8 8 88 8 888
          8:.,::,.:888
         .8\`::::::'888
         88  \`::'  888
        .88        \`888.
      .88'   .::.  .:8888.
      888.'   :'    \`'88:88.
    .8888'    '        88:88.
   .8888'     .        88:888
   \`88888     :        8:888'
    \`.:.88    .       .::888'
   .:::::88   \`      .:::::::.
  .::::::.8         .:::::::::
  :::::::::..     .:::::::::'
   \`:::::::::88888:::::::'
      rs\`:::'       \`:'
"
}
# }}}

# lol {{{
alias ':w'='printf "%blol what are you saving? %b\n" "\e[31m" "\e[0m"'
alias ':wq'='printf "%blol wat %b\n" "\033[31m" "\e[0m"'
alias ':q'='printf "%bdo you even know where you are %b\n" "\033[31m" "\e[0m"'
# }}}

# vim: foldmethod=marker:
