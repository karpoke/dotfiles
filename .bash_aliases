#!/usr/bin/env bash

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
alias ..=__cd

# to avoid `..` to be aliased by other scripts
__alias () {
    if [[ "$1" =~ \.\.=.+ ]]; then
        false
    else
        builtin alias "$@"
    fi
}
alias alias=__alias

# to make sure special and critical system files are opened with the
# addecuated commands. also make it easier open files into the
# desired line or the most recent opened file
__vim () {
    local fn
    local ln
    local re

    fn="$(readlink -f "$1")"
    if [ "$fn" == "/etc/passwd" ]; then
        /usr/bin/env sudo vipw -p
    elif [ "$fn" == "/etc/shadow" ]; then
        /usr/bin/env sudo vipw -s
    elif [ "$fn" == "/etc/group" ]; then
        /usr/bin/env sudo vigr
    elif [ "$fn" == "/etc/sudoers" ]; then
        /usr/bin/env sudo visudo
    else
        # allow things like this:
        # vim ./bookcore/apps/conector/servicios/motor/motor.py:818
        fn=${@%:*}
        ln=${@#*:}
        re='^[0-9]+$'
        if [[ -r "$(readlink -f "$fn")" && "$ln" =~ $re ]]; then
            vim "$fn" +"$ln"
        elif [ -n "$@" ]; then
            /usr/bin/env vim "$@"
        else
            # edit last opened file
            /usr/bin/env vim -c "normal '0"
        fi
    fi
}
alias vim=__vim
