# alias for bash and zsh bash directory shortcuts {{{
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

export BK BOK DOT GAM LS MOV MUS SHO ANI SL STE
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

alias duf='duf -hide special'

# alias ssh='TERM=xterm-color ssh'
alias tree='tree -C --filelimit 20 --dirsfirst'
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
alias mvp='mpv'
alias tuch='touch'

alias vi='vim'
alias cim='vim'
alias vom='vim'
# }}}

# added commands or wrappers {{{
# system {{{
alias zsrc='source "${ZDOTDIR}/.zshrc"'

mktodir() { mkdir -p "$@" && cd "$@"; }

shutdown_in() {
    local count
    count="$1"

    if ! [[ $count =~ '^[0-9]+$' ]]; then
        printf "did not get a number to count down\n"
    fi

    while (($count > 0)); do
        printf 'shut down in %s\n' "$count"
        count=$((count - 1))
        sleep 1
    done

    shutdown now
}

get_pacman_mirrors() {
    echo "WARNING very slow (sent to stderr)" 1>&2
    reflector --country us --fastest 20  --protocol https --sort rate
}
# }}}

sh_history() {
    # or do both
    if [[ $SHELL =~ zsh ]]; then
        cat ~/.zsh_history
    else
        cat ~/.bash_history
    fi
}

g_history() {
    sh_history | grep ${@}
}

f_history() {
    sh_history | fzf
}

fc-fzf() {
    local copy output

    copy=0

    local print_help() {
        printf '%s' "fc-select [OPTION]"
        printf '%s' "  --copy, -c      copy selected font to clipboard"
    }

    while [[ -n $1 ]]; do
        case "$1" in
            --copy|-c)
                copy=1
                ;;
            -h|-H|--help)
                print_help
                return 1
                ;;
        esac
        shift
    done

    # example
    # /usr/share/fonts/100dpi/courO12.pcf.gz: Adobe Courier:style=Oblique
    #
    # get the font name from inside the colons .*: Adobe Courier:.*
    # s/.*:\(.*\):.*/\1/

    # output="$(fc-list \
    #     | sed 's/.*:\(.*\):.*/\1/'  \
    #     | awk '{$1=$1;print}' \
    #     | fzf )"
    output="$(fc-list \
        | fzf \
        | sed 's/.*:\(.*\):.*/\1/'  \
        | awk '{$1=$1;print}' )"

    if (($copy > 0)); then
        printf '%s' "$output" | wl-copy
    fi

    printf '%s\n' "$output"
    return 0
}

Bmpv() {
    mpv "$@" &>/dev/null &
}

menu() {
    local thing cmd items
    items=''
    thing='thing'
    cmd="$1"

    while true; do
        thing=''
        items="$(ls -1 | sort)"

        thing="$(printf 'exit\n%s\n' $items | fzf)"
        if [[ -n $thing ]] && [[ $thing != exit ]]; then
            $cmd "$thing"
        else
            break
        fi
    done
}

img() {
    if [[ $TERM == *kitty* ]]; then
        kitty + icat "$@"
    fi
}

to_lower() {
    tr '[:upper:]' '[:lower:]'
}

to_upper() {
    tr '[:lower:]' '[:upper:]'
}

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

figlet_fzf() {
    local input font output
    input="$1"

    font="$(figlist  | fzf --preview "figlet -f {} $input")"


    output="$(figlet -f "$font" "$input")"

    printf 'font used: %s\n\n%s\n\n' "$font" "$output"
}

# }}}

# editor {{{
# set up config file aliases
# TODO: there are so many ways this could be improved
{
    # get the current shell name, $$ is the current running proses
    CONFIG_SHELL="$(ps -p "$$" -o comm=)"

    # declare an associative array
    declare -A dot_files

    dot_files[brconf]='"${HOME}/.bashrc"'
    dot_files[baconf]='"${HOME}/.dots/scripts/bash_aliases.bash"'
    dot_files[zrconf]='"${HOME}/.zshrc.d/.zshrc"'
    dot_files[alconf]='"${HOME}/.config/alacritty/alacritty.yml"'
    dot_files[poconf]='"${HOME}/.config/polybar/config.ini"'
    dot_files[i3conf]='"${HOME}/.config/i3/config"'
    dot_files[weconf]='"${HOME}/.config/wezterm/wezterm.lua"'
    dot_files[kiconf]='"${HOME}/.config/kitty/kitty.conf"'

    dot_files[nvconf]='+"cd ${HOME}/.config/nvim" "${HOME}/.config/nvim/init.lua"'
    dot_files[org]='+"cd ${HOME}/notebook" "${HOME}/notebook/index.org"'

    keys=''
    dots_list=''

    if [[ $CONFIG_SHELL == zsh ]]; then
        setopt shwordsplit
        keys="${(k)dot_files}"

        dots_list="${(v)dot_files}"
    else
        keys="${!dot_files[@]}"

        dots_list="${dot_files[@]}"
    fi


    for key in $keys; do
        alias $key='$EDITOR '"${dot_files[$key]}"

        zlong_ignore_cmds+="$key "
    done

    if [[ $CONFIG_SHELL == zsh ]]; then
        unsetopt shwordsplit
    fi

    # a helper function, mostly for the `vim_dots` alias
    clean_dot_file_paths() {
        echo "$@" \
            | envsubst \
            | sed -E 's|" "|\n|g' | tr -d '"' | sed '/^$/d'
    }

    # this is kinda shitty, {ba,zs}sh doesn't export arrays of any
    # kind so we use an exported string space separated paths
    #   (e.g. "echo '"${HOME}/.config/i3/config" "${HOME}/.bashrc" ..  )
    export all_dot_files

    all_dot_files=$(clean_dot_file_paths "$dots_list")

    alias v_dots='echo "$all_dot_files" \
        | vim \
            +"setlocal noswapfile" \
            +"setlocal buftype=nofile" \
            +"setlocal bufhidden=hide" \
            +"setlocal filetype=dirvish"'
    # vim cmds {{{

    alias v_update='vim '${dot_files[nvconf]}' +"PackerSync"'

    alias view='$EDITOR -R -u ${HOME}/.config/nvim/view_init.vim'
    alias wim='$EDITOR -u "${HOME}/.config/nvim/writing_init.vim"'

    v_help() { vim +"help $1 | only"; }
    # }}}

    unset dot_files

    zlong_ignore_cmds+='v_dots '
}
# }}}

# extra not used much {{{

layout() {
    local line_color='\033[32m'
    local reset='\033[0m'

    printf '%b╓───── d i s k . u s a g e\n' \
        "$line_color"
    printf '╙────────────────────────────────────── ─ ─ %b \n' \
        "${reset}"

    local df_output="$(df)"

    local header="$(echo "$df_output" | cut -d$'\n' -f1 )"
    local body="$(echo "$df_output" | grep '^/dev'  |  sort -k 6.1)"

    echo "${header}\n${body}"
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

# vim: foldmethod=marker filetype=zsh:
