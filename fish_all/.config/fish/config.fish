# if status is-login
#     if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#         exec Hyprland
#     end
# end

if status is-interactive
    fish_add_path ~/bin

    # Commands to run in interactive sessions can go here
    set -U fish_greeting

    set --global --export EDITOR nvim

    set --global --export ANI "/mnt/slowlinuxstorage/anime/"
    abbr --add ani "cd $ANI"

    alias vim=nvim

    # alias's {{{
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

    # alias dirs='dirs -v'

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

    alias clock='tty-clock'
    alias jj='journalctl'
    alias py='python'
    alias ipy='ipython'
    alias job='jobs'
    # dir is ls but with different options https://askubuntu.com/questions/103913/
    alias dir='dirs'
    alias zn='znotes'

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

    # alias's for EDITOR {{{
    alias ficonf="$EDITOR ~/.config/fish/config.fish"
    alias hyconf="$EDITOR ~/.config/hypr/hyprland.conf"
    alias ewconf="$EDITOR ~/.config/eww/eww.yuck"
    alias kiconf="$EDITOR ~/.config/kitty/kitty.conf"
    alias nvconf="$EDITOR +'cd ~/.config/nvim/' ~/.config/nvim/init.lua"
    # }}}

    # lol {{{
    alias ':w'='printf "%blol what are you saving? %b\n" "\e[31m" "\e[0m"'
    alias ':wq'='printf "%blol wat %b\n" "\033[31m" "\e[0m"'
    alias ':q'='printf "%bdo you even know where you are %b\n" "\033[31m" "\e[0m"'
    # }}}
    # }}}

    # abbr {{{
    abbr --add --position anywhere trlu tr '[:lower:]' '[:upper:]'
    abbr --add --position anywhere trul tr '[:upper:]' '[:lower:]'
    # }}}

    function get_pacman_mirrors
        reflector --country us --fastest 20  --protocol https --sort rate
    end

    function Bmpv
        mpv "$argv" &>/dev/null & ; disown
    end

    function man
        # start blinking
        # set -x LESS_TERMCAP_mb (set_color --bold magenta)
        # start bold
        set -x LESS_TERMCAP_md (set_color --bold magenta)

        # start stand out
        set -x LESS_TERMCAP_so (set_color yellow)
        # end stand out
        set -x LESS_TERMCAP_se (set_color normal)

        # start underline
        set -x LESS_TERMCAP_us (set_color --underline cyan)
        # end underline
        set -x LESS_TERMCAP_ue (set_color normal)

        # end all mods
        set -x LESS_TERMCAP_me (set_color normal)

        command man $argv
    end

    starship init fish | source

    # why is this not a built in option, god damn
    function disown_on_exit --on-event fish_exit
        disown (jobs -p)
    end
end

# vim: foldmethod=marker
