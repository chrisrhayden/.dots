# ~/.bashrc
# shellcheck disable=2148,1091,1090

# if an i is present shell is interactive, the $- is shell options
# see https://www.gnu.org/software/bash/manual/bash.html#Invoking-Bash

[[ $- != *i* ]] && return

PATH="${PATH}:${HOME}/bin:${HOME}/go/bin:${HOME}/.cargo/bin"

# bash settings {{{
# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it
# regardless of the directory you're in
shopt -s cdable_vars

# can expand alias with esc C-e
shopt -s expand_aliases

# If  set,  and  readline  is being used, bash will attempt
# to perform hostname completion when a word containing a @  is  being  completed
# (see Completing under READLINE above).  This is enabled by default.
# shopt -s hostcomplete

# record each line as it gets issued
#PROMPT_COMMAND='history -a'

# idk if i need this or should be set somewhere else
LC_ALL=en_US.UTF-8

# HUGE history, The GREATEST history, all other history is FAKE history.
HISTSIZE=500000
HISTFILESIZE=100000

# avoid duplicate entries
# HISTCONTROL="ignoreboth"

# from https://github.com/mrzool/bash-sensible/blob/master/sensible.bash
# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Don't record some commands
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
# }}}

# set prompt {{{
pre_prompt() {
    PS1=$(make_ps1 'bash')
}

if hash make_ps1 2>/dev/null; then
    PROMPT_COMMAND=pre_prompt
else
    PS1='\[\033[34m\]┌─╼\[\033[35m\] \w\n\[\033[34m\]└──▶\[\033[0m\] '
fi
# }}}

# env varibals {{{
# shellcheck disable=2016
GIT_EDITOR='$EDITOR'
NLTK_DATA="$HOME/.local/share/nltk_data"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"

source_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm

    if [[ -n "$1" ]]; then
        nvm use "$1"
    fi
}

# if [[ -n $(command -v rustc) ]]; then
#     RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
#     export RUST_SRC_PATH
# fi

if [[ -n $(command -v nvim) ]]; then
    EDITOR='nvim'
    alias vim='nvim'

elif [[ -n $(command -v vim) ]]; then
    unalias vim 2>/dev/null
    EDITOR='vim'
fi

if [[ $(hostname) == 'Monolith' ]]; then
    export VAGRANT_HOME='/mnt/linuxstorage/vagrant.d'
fi


# color man pages
{
    # enter blinking mode - red
    LESS_TERMCAP_mb=$(printf '\e[01;31m')
    # enter bold, magenta
    LESS_TERMCAP_md=$(printf '\e[01;35m')
    # turn off/reset for all appearance modes (mb, md, so, us)
    LESS_TERMCAP_me=$(printf '\e[0m')
    # enter standout/reverse mode - yellow
    LESS_TERMCAP_so=$(printf '\e[01;33m')
    # leave standout/reverse mode
    LESS_TERMCAP_se=$(printf '\e[0m')
    # enter underline mode - cyan
    LESS_TERMCAP_us=$(printf '\e[04;36m') 
    # leave underline mode
    LESS_TERMCAP_ue=$(printf '\e[0m')
    export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_se
    export LESS_TERMCAP_so LESS_TERMCAP_ue LESS_TERMCAP_us
}

# }}}

# source files {{{
[[ -f ${HOME}.dots/scripts/bash_aliases.bash ]] && \
    source "${HOME}.dots/scripts/bash_aliases.bash"

[[ -f ${HOME}.dots/scripts/to.bash ]] && \
    source "${HOME}.dots/scripts/to.bash"

[[ -f ~/.dir_colors ]] && eval "$(dircolors -b ~/.dir_colors)"

[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && \
    source /usr/share/doc/pkgfile/command-not-found.bash
# }}}

export PATH PROMPT_COMMAND PS1 LC_ALL HISTFILESIZE HISTSIZES HISTIGNORE \
    EDITOR GIT_EDITOR NLTK_DATA XDG_CONFIG_HOME XDG_DATA_HOME

# vim: set foldmethod=marker:
