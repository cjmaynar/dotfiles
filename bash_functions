##!/bin/bash
#Custom bash functions

# Wrapper around all the extractor functions, since I can never
# remember which one does which
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1   ;;
            *.tar.gz)  tar xvzf $1   ;;
            *.bz2)     bunzip2 $1    ;;
            *.rar)     unrar x $1    ;;
            *.gz)      gunzip $1     ;;
            *.tar)     tar xvf $1    ;;
            *.tbz2)    tar xvjf $1   ;;
            *.tgz)     tar xvzf $1   ;;
            *.zip)     unzip $1      ;;
            *.Z)       uncompress $1 ;;
            *)         echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Outputs all the members of a specific group
members() {
    cat /etc/group | grep --regex "^$1:.*" | awk -F: '{print $4}'
}

function reload_tags() {
    ctags -f ./tags \
    -h \".php\" -R \
    --exclude=\"\.svn\" \
    --totals=yes \
    --tag-relative=yes \
    --PHP-kinds=+cfiv \
    --regex-PHP='/(abstract)?\s+class\s+([^ ]+)/\3/c/'
    --regex-PHP='/(static|abstract|public|protected|private)\s+(final\s+)?function\s+(\&\s+)?([^ (]+)/\4/f/'
    --regex-PHP='/interface\s+([^ ]+)/\1/i/'
    --regex-PHP='/\$([a-zA-Z_][a-zA-Z0-9_]*)/\1/v/])'
}

# Delete a line from the known_hosts file; used when the RSA key
# has changed
function rmhostkey() {
    sed -i "$1d" ~/.ssh/known_hosts
}

# cd to the directory of a python package
# ex: cdp django.contrib
cdp() {
    cd "$(python -c "import os.path as _, ${1}; \
            print(_.dirname(_.realpath(${1}.__file__[:-1])))"
        )"
}
