export EDITOR="vim"

export LESS="$LESS -iR"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export PYTHONDONTWRITEBYTECODE=false

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source functions file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Source functions file
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# override git completion function __git_find_on_cmdline() to work around
# a minor bug exposed by git flow completion
__git_find_on_cmdline ()
{
    [ -z "$cword" ] && return
    local word subcommand c=1
    while [ $c -lt $cword ]; do
        word="${words[c]}"
        for subcommand in $1; do
            if [ "$subcommand" = "$word" ]; then
                echo "$subcommand"
                return
            fi
        done
        ((c++))
    done
}


# Source a file of functions/aliases that are system unique
# Used to include things I don't want to get versioned
if [ -f ~/.bash_untracked ]; then
    . ~/.bash_untracked
fi


if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
fi

if type __git_ps1 >&/dev/null; then
    # tune the following exports for your needs
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    # redefine the command prompt to include git info, if the current directory is in a clone
    unset PS1
    PROMPT_COMMAND='__git_ps1 "\[\e[36;1m\][\u@\h \T \w]\[\e[33;0m\]" "\n\$ "'
fi

# TMUX
if which tmux >/dev/null 2>&1; then
    # if not in a tmux session, attach to existing session or start new one
    test -z "$TMUX" && (tmux attach -t cmaynard || tmux new-session -s cmaynard)
fi
