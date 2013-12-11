export EDITOR="vim"

export LESS="$LESS -iR"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

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

WORKON_HOME=$HOME/.virtualenvs
if hash apt-get 2>/dev/null; then
    possible_scripts='/usr/local/bin/virtualenvwrapper.sh /etc/bash_completion.d/virtualenvwrapper'
    for script in $possible_scripts; do
      [[ -f $script ]] && source $script
    done
else
    source virtualenvwrapper.sh
fi

