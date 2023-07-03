# ~/.zshrc.d/.zshrc

[[ $- != *i* ]] && return

# variables {{{

# zsh / system variables {{{
# idk if i need this or should be set somewhere else
LC_ALL=en_US.UTF-8
export LC_ALL

# set up paths {{{
# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH

PATH="${PATH}:${HOME}/bin:${HOME}/go/bin:${HOME}/.cargo/bin:${HOME}/.yarn/bin"

export path PATH cdpath CDPATH fpath FPATH
# }}}

# history settings {{{
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoredups

export HISTSIZE HISTFILE HISTCONTROL SAVEHIST
# }}}

# misc settings {{{
# watch logins for everyone but me and root, idk if i should export
watch=(notme root)

# KEYTIMEOUT=10

# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
REPORTTIME=5
export REPORTTIME


DIRSTACKSIZE=${DIRSTACKSIZE:-20}
DIRSTACKFILE=${DIRSTACKFILE:-${ZDOTDIR:-${HOME}}/.zdirs}

export DIRSTACKFILE DIRSTACKSIZE
# }}}

# PS{2..4} {{{
# secondary prompt, printed when the shell needs more information to complete a
# command.
PS2='\`%_> '
# selection prompt used within a select loop.
PS3='?# '
# the execution trace prompt (setopt xtrace). default: '+%N:%i>'
PS4='+%N:%i:%_> '

export PS2 PS3 PS4
# }}}

XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"

export XDG_DATA_HOME XDG_CONFIG_HOME

# color man pages {{{
{
    LESS_TERMCAP_mb=$'\e[01;31m' # enter blinking mode - red
    LESS_TERMCAP_md=$'\e[01;35m' # enter double-bright mode - magenta
    LESS_TERMCAP_me=$'\e[0m'     # turn off all appearance modes
    LESS_TERMCAP_se=$'\e[0m'     # leave standout mode
    LESS_TERMCAP_so=$'\e[01;33m' # enter standout mode - yellow
    LESS_TERMCAP_ue=$'\e[0m'     # leave underline mode
    LESS_TERMCAP_us=$'\e[04;36m' # enter underline mode - cyan
    export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_se \
        LESS_TERMCAP_so LESS_TERMCAP_ue LESS_TERMCAP_us
}
# }}}
# }}}

# program specific {{{
# fzf {{{
gen_fzf_default_opts() {
    # Base16 Isotope
    # Author: Jan T. Sott

    local color00='#000000'
    local color01='#404040'
    local color02='#606060'
    local color03='#808080'
    local color04='#c0c0c0'
    local color05='#d0d0d0'
    local color06='#e0e0e0'
    local color07='#ffffff'
    local color08='#ff0000'
    local color09='#ff9900'
    local color0A='#ff0099'
    local color0B='#33ff00'
    local color0C='#00ffff'
    local color0D='#0066ff'
    local color0E='#cc00ff'
    local color0F='#3300ff'

    local fzf_colors

    # " --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
    fzf_colors+=" --color=bg+:$color01,spinner:$color0C,hl:$color0D"
    fzf_colors+=" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"
    fzf_colors+=" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

    FZF_DEFAULT_OPTS+="$fzf_colors"

    export FZF_DEFAULT_OPTS
}

gen_fzf_default_opts
# }}}

# rust {{{
if hash rustup 2>/dev/null; then
    rust_tool="${HOME}/.rustup/toolchains/$(
        rustup show active-toolchain | cut -d ' ' -f1)"

    fpath=(
        "${rust_tool}/share/zsh/site-functions/"
        # make sure to expand the old paths
        "${fpath[@]}"
    )

    unset rust_tool
fi
# }}}

# BROWSER='qutebrowser'
# BROWSER='firefox'
# export BROWSER
# just rely on xdg for this
unset BROWSER

if [[ -n $(command -v nvim) ]]; then
    EDITOR='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d'

elif [[ -n $(command -v vim) ]]; then
    unalias vim 2>/dev/null
    unalias vimdiff 2>/dev/null
    EDITOR='vim'
else
    EDITOR=nano
fi

export EDITOR

# for the nnn file manager
NNN_FIFO=/tmp/nnn.fifo
NNN_PLUG='p:preview-tui'
export NNN_FIFO NNN_FIFO

GIT_EDITOR='$EDITOR'
export GIT_EDITOR

NLTK_DATA="$HOME/.local/share/nltk_data"
export NLTK_DATA
# }}}

# }}}

# useful functions {{{

# Check if we can read given files and source those we can.
function xsource () {
    while (( ${#argv} > 0 )) ; do
        if [[ -r "$1" ]]; then
            # echo "$1"
            source "$1"
        else
            printf 'file does not exist: %s\n' \
                "$1"
        fi

        shift
    done
}

# }}}

# options {{{

# save each command's beginning timestamp and the duration to the history file

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups

# Whenever the user enters a line with history expansion,  don't  execute  the
# line  directly;  instead, perform history expansion and reload the line into
# the editing buffer.
setopt hist_verify

# increment history file when command is entered instead of when shell exits
setopt inc_append_history

# remove command lines from the history list when the first character on the
# line is a space
# why should i care about this
# setopt histignorespace

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
# setopt extended_glob

# display PID when suspending processes as well
setopt longlistjobs

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# don't push the same dir twice.
setopt pushd_ignore_dups

# pushd works like pushd $HOME
setopt pushd_to_home

# * shouldn't match dotfiles. ever.
# setopt no_glob_dots

# use zsh style word splitting
setopt no_sh_word_split

# don't print dirs when using pushd or pop
setopt pushd_silent

# allow comments even in interactive shells
setopt interactive_comments

# cd to VAR if not a dir
setopt cdable_vars

# don't send hup to running jobs
setopt no_hup

# don't check for jobs when exiting a shell
setopt no_check_jobs

# report the status of backgrounds jobs immediately
# setopt notify

# don't beep, notify or correct me
setopt nobeep
unsetopt beep correct auto_remove_slash

# do not autoselect the first completion entry
unsetopt menu_complete

# If this option is unset, output flow control via start/stop characters
# (usu‐ ally assigned to ^S/^Q) is disabled in the shell's editor.
unsetopt flowcontrol

# }}}

# Load a few modules {{{
autoload -U compinit

# it doesn't seem to help much, maybe on my laptop
if [[ $(date +%F) != $(date +%F -r ${ZDOTDIR}/.zcompdump 2>/dev/null) ]]; then
    compinit
    # just to be sure
    touch "${ZDOTDIR}/.zcompdump"
else
    # -C = dont check for new functions
    compinit -C
fi

# Access to internal hash tables via special associative arrays.
zmodload zsh/parameter
zmodload zsh/mathfunc
# -a = auto load
# -ap = auto load but with params, like zmodload -ab i guess
# A builtin command interface to the stat system call.
zmodload -a  zsh/stat zstat
# A builtin for starting a command in a pseudo-terminal.
zmodload -a  zsh/zpty zpty
# Access to external files via a special associative array.
zmodload -ap zsh/mapfile mapfile
zmodload zsh/complist
# }}}

# completions {{{
# show completion menu on successive tab press
setopt auto_menu

# complete inside words
setopt complete_in_word
# If a completion is performed with the cursor within a word, and a full
# completion  is  inserted, the cursor is moved to the end of the word
setopt always_to_end

# idk why its empty, i guess it just acts like only alphanumeric
WORDCHARS=''

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${COMPDUMPFILE}
zstyle ':completion:*' rehash true

zstyle ':completion:*' macher-list 'm:{a-zA-Z}={A-za-z}' 'r:|[._-]=* r:|=*' 'l:=* r:|=*'

zstyle ':completion:*:*:*:*:*' menu select=5

# see how-does-the-zsh-list-colors-syntax-work
# https://stackoverflow.com/questions/23152157/
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*:processes' list-colors \
    '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au $USER'

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' \
    command 'ps c -u ${USER} -o command | uniq'

# disable named-directories autocompletion, idk what this means
zstyle ':completion:*:cd:*' tag-order \
    local-directories directory-stack path-directories

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   false
zstyle ':completion:*:man:*'      menu yes select

# TODO: maybe add host name completion
# provide .. as a completion, like (ls ..<tab> = ls ../path)
zstyle ':completion:*' special-dirs ..

# use generic completion system for programs not yet defined; (_gnu_generic works
# with commands that provide a --help option with "standard" gnu-like output.)
# generic_cmds+=(
# 'cp'
# 'deborphan'
# 'df'
# 'feh'
# 'fetchipac'
# 'gpasswd'
# 'head'
# 'hnb'
# 'ipacsum'
# 'mv'
# 'pal'
# 'stow'
# 'unam'
# 'grim'
# )

# for gen_cmd in ${generic_cmds[@]}; do
#     [[ -z ${_comps[$gen_cmd]} ]] && compdef _gnu_generic ${gen_cmd}
# done; unset gen_cmd generic_cmds

# describe options in full
zstyle ':completion:*:options'         description 'yes'

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# }}}

# zle settings {{{
# mostly stolen from grml
# Use emacs-like key bindings by default:
bindkey -e

# only slash should be considered as a word separator:
function slash-backward-kill-word () {
    local WORDCHARS="${WORDCHARS:s@/@}"
    # zle backward-word
    zle backward-kill-word
}
zle -N slash-backward-kill-word

# power completion / abbreviation expansion / buffer expansion
# see http://zshwiki.org/home/examples/zleiab for details
# less risky than the global aliases but powerful as well
# just type the abbreviation key and afterwards 'ctrl-x .' to expand it
declare -A abk
abk=(
# key  # value                 (#d additional doc string)
'...'  '../..'
'....' '../../..'
'BG'   '& exit'
'C'    '| wc -l'
'H'    '| head'
'Hl'   ' --help |& less -r'    #d (Display help in pager)
'L'    '| less'
'LL'   '|& less -r'
'M'    '| most'
'N'    '&>/dev/null'           #d (No Output)
'R'    '| tr A-z N-za-m'       #d (ROT13)
'SL'   '| sort | less'
'S'    '| sort -u'
'T'    '| tail'
'V'    '|& vim -'
'co'   './configure && make && sudo make install'
)

function zleiab () {
    emulate -L zsh
    setopt extendedglob
    local MATCH

    LBUFFER=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}
zle -N zleiab

function help-show-abk () {
  zle -M "$(print "Available abbreviations for expansion:"; print -a -C 2 ${(kv)abk})"
}
zle -N help-show-abk

function grml-zsh-fg () {
  if (( ${#jobstates} )); then
    zle .push-input
    [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
    BUFFER="${BUFFER}fg"
    zle .accept-line
  else
    zle -M 'No background jobs. Doing nothing.'
  fi
}
zle -N grml-zsh-fg

# run command line as user root via sudo:
function man-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != man\ * ]]; then
        BUFFER="man $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N man-command-line

# run command line as user root via sudo:
function sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N sudo-command-line

# run command line as user root via sudo:
function pacman-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != pacman\ * ]]; then
        BUFFER="pacman $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N pacman-command-line

function slash-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="\\$BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N slash-command-line

function echo-xsel () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="printf '$BUFFER' | xsel"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N echo-xsel


### jump behind the first word on the cmdline.
### useful to add options.
function jump_before_first_word () {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[0]}}
    fi
}
zle -N jump_before_first_word

### jump behind the first word on the cmdline.
### useful to add options.
function jump_after_first_word () {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}
    fi
}
zle -N jump_after_first_word

## beginning-of-line OR beginning-of-buffer OR beginning of history
## by: Bart Schaefer <schaefer@brasslantern.com>, Bernhard Tittelbach
function beginning-or-end-of-somewhere () {
    local hno=$HISTNO
    if [[ ( "${LBUFFER[-1]}" == $'\n' && "${WIDGET}" == beginning-of* ) || \
      ( "${RBUFFER[1]}" == $'\n' && "${WIDGET}" == end-of* ) ]]; then
        zle .${WIDGET:s/somewhere/buffer-or-history/} "$@"
    else
        zle .${WIDGET:s/somewhere/line-hist/} "$@"
        if (( HISTNO != hno )); then
            zle .${WIDGET:s/somewhere/buffer-or-history/} "$@"
        fi
    fi
}
zle -N beginning-of-somewhere beginning-or-end-of-somewhere
zle -N end-of-somewhere beginning-or-end-of-somewhere

fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        # fill the edit buffer
        BUFFER="fg"
        # tell zsh to accept whatever is in the edit buffer
        zle accept-line
    # TODO: im unsure of the point of these lines
    # else
    #     zle clear-screen
    #     zle push-input
    fi
}
zle -N fancy-ctrl-z

# }}}

# to bind keys {{{
function zrcautozle () {
    emulate -L zsh
    local fnc=$1
    autoload -U $fnc && zle -N $fnc
}

function zrcgotwidget () {
    (( ${+widgets[$1]} ))
}

function zrcbindkey () {
    if (( ARGC )) && zrcgotwidget ${argv[-1]}; then
        bindkey "$@"
    fi
}

function bind2maps () {
    local i sequence widget
    local -a maps

    while [[ "$1" != "--" ]]; do
        maps+=( "$1" )
        shift
    done
    shift

    if [[ "$1" == "-s" ]]; then
        shift
        sequence="$1"
    else
        sequence="${key[$1]}"
    fi
    widget="$2"

    [[ -z "$sequence" ]] && return 1

    for i in "${maps[@]}"; do
        # echo "-M $i $sequence $widget"
        zrcbindkey -M "$i" "$sequence" "$widget"
    done
}

typeset -A key
key=(
    Home     "${terminfo[khome]}"
    End      "${terminfo[kend]}"
    Insert   "${terminfo[kich1]}"
    Delete   "${terminfo[kdch1]}"
    Up       "${terminfo[kcuu1]}"
    Down     "${terminfo[kcud1]}"
    Left     "${terminfo[kcub1]}"
    Right    "${terminfo[kcuf1]}"
    PageUp   "${terminfo[kpp]}"
    PageDown "${terminfo[knp]}"
    BackTab  "${terminfo[kcbt]}"
)

zrcautozle run-help
zrcautozle insert-files
zrcautozle edit-command-line

autoload history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end

zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history

# Guidelines for adding key bindings:
#
#   - Do not add hardcoded escape sequences, to enable non standard key
#     combinations such as Ctrl-Meta-Left-Cursor. They are not easily portable.
#
#   - Adding Ctrl characters, such as '^b' is okay; note that '^b' and '^B' are
#     the same key.
#
#   - All keys from the $key[] mapping are obviously okay.
#
#   - Most terminals send "ESC x" when Meta-x is pressed. Thus, sequences like
#     '\ex' are allowed in here as well.

bind2maps emacs             -- Home   beginning-of-somewhere
bind2maps       viins vicmd -- Home   vi-beginning-of-line
bind2maps emacs             -- End    end-of-somewhere
bind2maps       viins vicmd -- End    vi-end-of-line
bind2maps emacs viins       -- Insert overwrite-mode
bind2maps             vicmd -- Insert vi-insert
bind2maps emacs             -- Delete delete-char
bind2maps       viins vicmd -- Delete vi-delete-char
bind2maps emacs viins vicmd -- Up     up-line-or-search
bind2maps emacs viins vicmd -- Down   down-line-or-search
bind2maps emacs             -- Left   backward-char
bind2maps       viins vicmd -- Left   vi-backward-char
bind2maps emacs             -- Right  forward-char
bind2maps       viins vicmd -- Right  vi-forward-char
#k# Perform abbreviation expansion
bind2maps emacs viins       -- -s '^x.' zleiab
#k# Display list of abbreviations that would expand
bind2maps emacs viins       -- -s '^xb' help-show-abk
#k# Insert files and test globbing
bind2maps emacs viins       -- -s "^xf" insert-files
#k# Edit the current line in \kbd{\$EDITOR}
# bind2maps emacs viins       -- -s '\ee' edit-command-line
bind2maps emacs viins       -- -s '^x^e' edit-command-line
#k# search history backward for entry beginning with typed text
bind2maps emacs viins       -- -s '^xp' history-beginning-search-backward-end
#k# search history forward for entry beginning with typed text
bind2maps emacs viins       -- -s '^xP' history-beginning-search-forward-end
bind2maps emacs viins       -- -s '^xn' history-beginning-search-forward-end
#k# search history backward for entry beginning with typed text
bind2maps emacs viins       -- PageUp history-beginning-search-backward-end
#k# search history forward for entry beginning with typed text
bind2maps emacs viins       -- PageDown history-beginning-search-forward-end
#k# Kill left-side word or everything up to next slash
bind2maps emacs viins       -- -s '\ev' slash-backward-kill-word
# Do history expansion on space:
bind2maps emacs viins       -- -s ' ' magic-space
#k# Trigger menu-complete
bind2maps emacs viins       -- -s '\ei' menu-complete  # menu completion via esc-i
#k# A smart shortcut for \kbd{fg<enter>}
bind2maps emacs viins       -- -s '^z' grml-zsh-fg
#k# prepend the current command with "sudo"
bind2maps emacs viins       -- -s "^os" sudo-command-line
bind2maps emacs viins       -- -s "^om" man-command-line
bind2maps emacs viins       -- -s "^op" pacman-command-line
bind2maps emacs viins       -- -s "^o\\" slash-command-line
bind2maps emacs viins       -- -s "^\\" slash-command-line
bind2maps emacs viins       -- -s "^o^e" echo-xsel
#k# jump to after first word (for adding options)
bind2maps emacs viins       -- -s '^x1' jump_after_first_word
#k# complete word from history with menu
bind2maps emacs viins       -- -s "^x^x" hist-complete

# idk if ill ever use it
# insert unicode character
# usage example: 'ctrl-x i' 00A7 'ctrl-x i' will give you an §
# See for example http://unicode.org/charts/ for unicode characters code
#k# Insert Unicode character
bind2maps emacs viins       -- -s '^xi' insert-unicode-char

# use the vi navigation keys (hjkl) besides cursor keys in menu completion
bindkey -M menuselect 'h' vi-backward-char        # left
bindkey -M menuselect 'k' vi-up-line-or-history   # up
bindkey -M menuselect 'l' vi-forward-char         # right
bindkey -M menuselect 'j' vi-down-line-or-history # bottom

# i add
bindkey '\e#' pound-insert
bindkey '^M#' pound-insert

bindkey '^Z' fancy-ctrl-z
# }}}

# PS1 {{{
eval "$(starship init zsh)"

# precmd() {
#     PS1="$(make_ps1 zsh)"
# }

export PS1
# }}}

# plugin settings {{{
xsource "${HOME}/.zshrc.d/zsh_plugins.sh"

fast-theme ~/.zshrc.d/zsh_syntax_theme.ini 1>/dev/null

# zlong_ignore_cmds='ssh man htop mocp'
zlong_ignore_cmds='ssh man htop mocp view wim vim_help py python spt vim nvim '

zlong_duration=40
export zlong_ignore_cmds zlong_duration

source_nvm() {
    NVM_DIR="$HOME/.nvm"
    if [[ ! -e /usr/share/nvm/init-nvm.sh ]] \
        || [[ ! -e "$NVM_DIR/init-nvm.sh" ]]; then
        echo 'nvm does not exists'
        return
    fi

    xsource /usr/share/nvm/init-nvm.sh
    xsource "$NVM_DIR/init-nvm.sh"

    if [[ -n "$1" ]]; then
        nvm use "$1"
    else
        nvm use node # the latest
    fi

    # for ps1
    NVM_VERSION="$(nvm_version)"
    export NVM_VERSION
}
# }}}

# source things {{{

# "${HOME}/.dots/scripts/config_vars.sh"
xsource "${HOME}/.dots/scripts/bash_aliases.bash" \
    "${HOME}/.dots/scripts/to.sh"

# eval the LS_COLORS variable from dircolors -b file
[[ -f ~/.dir_colors ]] && eval "$(dircolors -b ~/.dir_colors)"
# }}}

# setopt globsubst

# vim: foldmethod=marker
