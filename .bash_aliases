#!/usr/bin/env bash

# some useful sources
# https://github.com/Bash-it/bash-it/tree/master/aliases/available
# https://github.com/ohmybash/oh-my-bash/tree/master/aliases
# https://www.commandlinefu.com/commands/browse

# remember:
# ^xe       Open an editor and execute a command
# fc        Rapidly invoke an editor to write a command
# !:-       Insert the last command without the last argument
# <Esc> *
# !*        All parameter from the previous command line
# !!        Last command
# $_        Las argument
# ^foo^bar  Replace foo by bar in the previous command
# Alt+.     Last argument from the last command
# Esc+.     "
# Esc+_
# Alt+num+. n-th argument from the last command
# <Esc>+*   Insert the results of an autocmpletion

# TODO:
# intercept stdout/stderr:  strace -ff -e trace=write -e write=1,2 -p SOME_PID
# show apps that use the internet connection: ss -p


# shortcuts
alias apd='sudo apt list --upgradable'
alias apg='sudo apt upgrade'
alias aph='apt show'
alias api='sudo apt install'
alias app='sudo apt autoremove && sudo apt clean && sudo apt autoclean'
alias aps='apt search'
alias apu='sudo apt update'
alias cls='clear'
alias cp='cp -i'
alias cpv='rsync -ah --info=progress2'
alias grep='grep --color -i --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ls='ls --color=tty'
alias lt='ls --human-readable --size -1 -S --classify'
alias mkdir='mkdir -pv'
# shellcheck disable=SC2142
alias mnt='mount | awk -F'\'' '\'' '\''{ printf "%s\t%s\n",$1,$3; }'\'' | column -t | egrep ^/dev/ | sort'
alias mv='mv -iv'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias perm='stat --printf "%a %n \n"'
alias rm='rm -iv'
alias rsync='rsync -vh'
alias ssh='ssh -C'
alias wget='wget -c'
alias xargs='xargs -r'

# https://cirw.in/blog/bracketed-paste
# http://thejh.net/misc/website-terminal-copy-paste
alias enable_bracketed_paste_mode='printf "\e[?2004h"'
alias disable_bracketed_paste_mode='printf "\e[?2004l"'

alias upgrade_fzf='cd ~/.fzf && git pull && ./install'

# one-liner utilities
__k_bak () { [ -r "$1" ] && mv "$1"{,.bak}; }
__k_cmd2img () { convert -font courier -pointsize 12 -background black -fill white label:"$("$@")" -trim output.png; }
__k_ipinfo () { curl -s "http://ipinfo.io/$1"; }
__k_http_status () { curl -s -o /dev/null -w "%{http_code}" "$1"; }
__k_random_uuid_to_dev () { dev="$1"; sudo umount /dev/"$dev" && tune2fs /dev/"$dev" -U random; }
__k_rip_audio () { output="${1%.*}-ripped.${1##*.}"; mplayer -ao pcm -vo null -vc dummy -dumpaudio -dumpfile "$output" "$1"; }
__k_slugify () { echo "$*" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr '[:upper:]' '[:lower:]'; }

__k_test_slugify () {
    # some punctuation
    test "$(__k_slugify ',.;:_-+─=ºª¡!"·$%&/()[]{}¿?|@#~½¬')" == "oa-1-2" &&
    # some non-ascii charcters
    test "$(__k_slugify 'áÁàÀăĂâÂåÅäÄąĄæÆćĆčČçÇđĐéÉèÈėĖęĘğíÍîÎïÏįĮıňŇñÑóÓòÒöÖőŐõÕøØšŠşŞţŢúÚüÜűŰųŲūŪýÝžŽ')" == "aaaaaaaaaaaaaaaeaeccccccddeeeeeeeegiiiiiiiiinnnnoooooooooooossssttuuuuuuuuuuyyzz";
}

alias bak=__k_bak
alias cat=__k_cat
alias clock='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
alias cmd2img=__k_cmd2img
alias dkelc='docker exec -it $(dklcid) bash --login'
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'
alias ipinfo=__k_ipinfo
alias get_developer_excuses='curl -s  http://developerexcuses.com/ | grep nofollow | grep -Eo ">[^<]+" | cut -b 2-'
alias http_status=__k_http_status
alias make1mb='truncate -s 1m ./1MB.dat'
alias myip='curl -A firefox -s https://www.ignaciocano.com/ip'
alias http_server='python -m SimpleHTTPServer'
# shellcheck disable=SC2142
alias remove_duplicated_lines='awk '\''!x[$0]++'\'''
alias random_uuid_to_dev=__k_random_uuid_to_dev
alias rip_audio=__k_rip_audio
alias slugify=__k_slugify
alias smtp_debug_server='python -m smtpd -n -c DebuggingServer localhost:1025'
alias timewatch='(trap '\''kill -sSIGHUP $PPID'\'' SIGINT && echo "Stop it with ^D" && time read)'

# shellcheck disable=SC2139 disable=SC1083
alias best_ubuntu_server="curl -s http://mirrors.ubuntu.com/mirrors.txt | xargs -n1 -I {} sh -c 'echo $(curl -r 0-102400 -s -w %{speed_download} -o /dev/null {}/ls-lR.gz) {}' | sort -gr | head -3 | awk '{ print $2 }'"
# https://github.com/nvbn/thefuck
alias fuck='eval $(thefuck $(fc -ln -1))'

# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
alias j='jump'

# aliased functions defined below
alias ..=__k_..
alias cd=__k_cd
alias vim=__k_vim

# improved cd'ing
# examples:
# `..` go up one directory
# `.. 3` go up three directories
# `.. foo` go up to the most upper directory whose name is `foo`
__k_.. () {
    local n
    local oldpwd
    local path
    local re

    oldpwd="$PWD"
    re='^[0-9]+$'
    if [[ -z "$1" ]] || [[ "$1" =~ ^[0-9]+$ ]]; then
        let n="${1:-1}"
        path="."
        while [ $n -gt 0 ] && [ "$PWD" != "/" ]; do
            path="$path/.."
            ((n--))
        done
        builtin cd "$path"
    else
        builtin cd "${PWD/$1*/$1}"
    fi
    OLDPWD="$oldpwd"
}

# go to directory even if a file is passed as param
__k_cd () {
    local path
    if [ -f "$1" ]; then
        path="$(dirname "$1")"
        builtin cd "$path"
    elif [ -z "$1" ]; then
        builtin cd
    else
        builtin cd "$@"
    fi
}

# to make sure special and critical system files are opened with the
# addecuated commands. also make it easier open files into the
# desired line or the most recent opened file
__k_vim () {
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
        # vim foo/bar.c:123
        fn=${1%:*}
        ln=${1#*:}
        re='^[0-9]+$'
        if [[ -r "$(readlink -f "$fn")" && "$ln" =~ $re ]]; then
            env vim "$fn" +"$ln"
        elif [[ -n "$@" ]]; then
            env vim "$@"
        else
            # edit last opened file on the last line
            env vim -c "normal '0"
        fi
    fi
}

__k_cat () {
    if [ "$#" -eq 1 ] && [  -d "$1" ]; then
        ls "$1"
    elif [ "$#" -eq 0 ]; then
        /bin/cat
    else
        command -v bat && bat "$@" || /bin/cat "$@"
    fi
}

# to avoid `..` to be aliased by other scripts. this must be at the end of the
# file
__k_alias () {
    if [[ "$1" =~ \.\.=.+ ]]; then
        false
    else
        builtin alias "$@"
    fi
}
alias alias=__k_alias
