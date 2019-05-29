#!/usr/bin/env bash

# basics
alias api='sudo apt install'
alias apu='sudo apt update'
alias apg='sudo apt upgrade'
alias aps='apt search'
alias aph='apt show'
alias app='sudo apt autoremove && sudo apt clean && sudo apt autoclean'

alias rm='rm -iv'
alias mv='mv -iv'
alias grep='grep --color -i'
alias ssh='ssh -C'

# one-liner utilities
alias myip='curl -s ifconfig.me'

# aliased functions defined below
alias ..=__cd
alias bak=__bak
alias ipinfo=__ipinfo
alias vim=__vim

# improved cd'ing
# examples:
# `..` go up one directory
# `.. 3` go up three directories
# `.. foo` go up to the most upper directory whose name is `foo`
__cd () {
    local n
    local oldpwd
    local path
    local re

    oldpwd="$PWD"
    re='^[0-9]+$'
    if [[ -z "$1" ]] || [[ "$1" =~ ^[0-9]+$ ]]; then
        let n="${1:-1}"
        path="."
        while [ $n -gt 0 -a "$PWD" != "/" ]; do
            path="$path/.."
            n=$((n-1))
        done
        builtin cd "$path"
    else
        builtin cd "${PWD/$1*/$1}"
    fi
    OLDPWD="$oldpwd"
}

# fast and easy back-up
__bak () {
    [ -w "$1" ] && mv "$1"{,.bak}
}

# get IPinfo
__ipinfo () {
    curl -s ipinfo.io/"$1"
}

# to make sure special and critical system files are opened with the
# addecuated commands. also make it easier open files into the
# desired line or the most recent opened file
__vim () {
    local fn
    local ln
    local re

    fn="$(readlink -f "$1")"
    if [ "$fn" == "/etc/passwd" ]; then
        sudo vipw -p
    elif [ "$fn" == "/etc/shadow" ]; then
        sudo vipw -s
    elif [ "$fn" == "/etc/group" ]; then
        sudo vigr
    elif [ "$fn" == "/etc/sudoers" ]; then
        sudo visudo
    else
        # allow things like this:
        # vim ./bookcore/apps/conector/servicios/motor/motor.py:818
        fn=${@%:*}
        ln=${@#*:}
        re='^[0-9]+$'
        if [[ -r "$(readlink -f "$fn")" && "$ln" =~ $re ]]; then
            env vim "$fn" +"$ln"
        elif [[ -n "$@" ]]; then
            env vim "$@"
        else
            # edit last opened file
            env vim -c "normal '0"
        fi
    fi
}

# to avoid `..` to be aliased by other scripts. this must be at the end of the
# file
__alias () {
    if [[ "$1" =~ \.\.=.+ ]]; then
        false
    else
        builtin alias "$@"
    fi
}
alias alias=__alias
