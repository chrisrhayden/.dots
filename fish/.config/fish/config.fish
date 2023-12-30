if status is-login
    if test \( -z "$DISPLAY"  \) -a \( "$XDG_VTNR" -eq "1" \)
        # exec Hyprland

        if test (hostnamectl hostname) = "Odimm";
            startx
        else
            Hyprland
        end
    end
end

# function show_startup_msg
#     set -l first_start ~/.cache/first_start
#
#     set -l cache_file (stat --printf '%Y' "$first_start")
#
#     if test $status -gt 0
#         touch "$first_start"
#         return
#     end
#
#     set -l boot_time (cat /proc/stat | rg 'btime' | cut -d' ' -f2)
#
#     if test $boot_time -gt $cache_file
#         neofetch
#     end
#     touch "$first_start"
# end

if status is-interactive
    # show_startup_msg

    fish_add_path ~/bin

    # Commands to run in interactive sessions can go here
    set -U fish_greeting

    set --global --export ANI "/mnt/slowlinuxstorage/anime/"
    abbr --add ani "cd $ANI"

    set --global --export MOV "/mnt/linuxstorage/movies/"
    abbr --add mov "cd $MOV"

    set --global --export EDITOR nvim
    alias vim=nvim
    alias nvconf="$EDITOR +'cd ~/.config/nvim/' ~/.config/nvim/init.lua"

    # alias's {{{
    alias ls='ls --color'
    alias grep='grep --color'
    alias diff='diff --color'

    alias mv='mv --interactive'
    alias rm='rm --interactive'
    alias cp='cp --interactive'

    alias fd='fd --hidden --one-file-system'
    alias rg='rg --hidden --one-file-system'

    alias df='df --human'
    alias free='free --human'
    alias xsel='xsel --clipboard'

    alias duf='duf -hide special'

    alias tree='tree -C --filelimit 20 --dirsfirst'
    alias gdb='gdb --quiet'
    alias info='info --vi-keys'
    alias lsblk='lsblk --output name,size,fstype,mountpoint'
    alias bat='bat --paging never --style plain --wrap character --color auto'
    alias radeontop='radeontop  --color'
    alias tty-clock='tty-clock -t -c -C 5'
    alias clock='tty-clock'
    alias unimatrix='unimatrix --character-list=k --speed=90'
    alias matrix='unimatrix'

    alias jj='journalctl'
    alias py='python'
    alias job='jobs'
    alias tii='tii --color magenta'

    # misspelling {{{
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

    alias ':w'='printf "%blol what are you saving? %b\n" "\e[31m" "\e[0m"'
    alias ':wq'='printf "%blol wat %b\n" "\033[31m" "\e[0m"'
    alias ':q'='printf "%bdo you even know where you are %b\n" "\033[31m" "\e[0m"'
    alias fuck='echo "fuck"'
    # }}}

    # abbr {{{
    abbr --add --position anywhere trlu tr '[:lower:]' '[:upper:]'
    abbr --add --position anywhere trul tr '[:upper:]' '[:lower:]'
    # }}}

    function bak
        mv "$argv"{,.bak}
    end

    function get_pacman_mirrors
        reflector --country us --fastest 20  --protocol https --sort rate
    end

    function Bmpv
        mpv "$argv" &>/dev/null & ; disown
    end

    function man
        # set -x MANROFFOPT "-c"

        # LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        # LESS_TERMCAP_md=$(printf "\e[1;31m") \
        # LESS_TERMCAP_me=$(printf "\e[0m") \
        # LESS_TERMCAP_se=$(printf "\e[0m") \
        # LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        # LESS_TERMCAP_ue=$(printf "\e[0m") \
        # LESS_TERMCAP_us=$(printf "\e[1;32m") \

        # start blinking
        # set -x LESS_TERMCAP_mb (set_color --bold magenta)
        # start bold
        set -lx LESS_TERMCAP_md (set_color --bold normal)

        # start stand out
        set -lx LESS_TERMCAP_so (set_color yellow)
        # end stand out
        set -x LESS_TERMCAP_se (set_color normal)

        # start underline
        # set -x LESS_TERMCAP_us (printf '\\e[4;33m')
        set -x LESS_TERMCAP_us (set_color --underline)
        # end underline
        set -x LESS_TERMCAP_ue (set_color normal)

        # end all mods
        set -x LESS_TERMCAP_me (set_color normal)

        command man $argv
    end

    # why is this not a built in option, god damn
    function disown_on_exit --on-event fish_exit
        disown (jobs -p)
    end

    dircolors ~/.dir_colors -c | source

    starship init fish | source
end

# vim: foldmethod=marker
