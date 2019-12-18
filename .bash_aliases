#!/bin/bash

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
alias apd='apt list --upgradable'
alias apg='sudo apt upgrade'
alias aph='apt show'
alias api='sudo apt install'
alias app='sudo apt autoremove && sudo apt clean && sudo apt autoclean && sudo apt purge $(deborphan)'
alias aps='apt search'
alias apu='sudo apt update'
alias apr='sudo apt purge'
# add autocompletion for aliases
complete -c apd apg aph api apr

alias cp='cp -i'
alias dmesg='dmesg -wH'
alias grep='grep --color -i --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ln='ln -v'
alias ls='ls --color=tty'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rsync='rsync -vh'
alias ssh='ssh -C'
alias wget='wget -c'
alias xargs='xargs -r'

# shellcheck disable=SC2139 disable=SC1083
alias best_ubuntu_server="curl -s http://mirrors.ubuntu.com/mirrors.txt | xargs -n1 -I {} sh -c 'echo $(curl -r 0-102400 -s -w %{speed_download} -o /dev/null {}/ls-lR.gz) {}' | sort -gr | head -3 | awk '{ print $2 }'"
alias ch644='find . -type f -exec chmod -R 644 {} \;'
alias ch755='find . -type d -exec chmod -R 755 {} \;'
alias clock='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
alias cls='clear'
alias cpv='rsync -ah --info=progress2'
alias dkelc='docker exec -it $(dklcid) bash --login'
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'
alias get_developer_excuses='curl -s  http://developerexcuses.com/ | grep nofollow | grep -Eo ">[^<]+" | cut -b 2-'
alias hide_last='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'
alias http_server='python -m SimpleHTTPServer'
alias last_update='stat -c %y /var/cache/apt/pkgcache.bin'
alias lt='ls --human-readable --size -1 -S --classify -r'
alias make1mb='truncate -s 1m ./1MB.dat'
# shellcheck disable=SC2142
alias mnt='mount | awk -F'\'' '\'' '\''{ printf "%s\t%s\n",$1,$3; }'\'' | column -t | egrep ^/dev/ | sort'
alias myip='curl -A firefox -s https://www.ignaciocano.com/ip'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias perm='stat --printf "%a %n \n"'
# shellcheck disable=SC2142
alias remove_duplicated_lines='awk '\''!x[$0]++'\'''
alias smtp_debug_server='python -m smtpd -n -c DebuggingServer localhost:1025'
alias timewatch='(trap '\''kill -sSIGHUP $PPID'\'' SIGINT && echo "Stop it with ^D" && time read)'
alias upgrade_fzf='cd ~/.fzf && git pull && ./install'
alias what_the_commit="curl -s whatthecommit.com | grep '<p>' | sed 's/<p>//g'"

# https://cirw.in/blog/bracketed-paste
# http://thejh.net/misc/website-terminal-copy-paste
alias enable_bracketed_paste_mode='printf "\e[?2004h"'
alias disable_bracketed_paste_mode='printf "\e[?2004l"'

alias cat=__cat
alias cd=__cd
alias df=__df
alias vim=__vim

# one-liner utilities
function bak () { [ -r "$1" ] && mv "$1"{,.bak}; }
function cmd2img () { convert -font courier -pointsize 12 -background black -fill white label:"$("$@")" -trim output.png; }
function http_compression { curl -s -I -H "Accept-Encoding: br,gzip,deflate" -A "firefox" "$1" | grep -i "Content-Encoding"; }
function http_status () { curl -s -o /dev/null -w "%{http_code}" -A "firefox" "$1"; }
function ipinfo () { curl -s "http://ipinfo.io/$1"; }
function pyimport () { python -c "import $1"; }
function pypath () { python -c "import os, $1; print(os.path.dirname($1.__file__))"; }
function pysslcertspath () { python -c "import ssl; print(ssl.get_default_verify_paths())"; }
function random_uuid_to_dev () { dev="$1"; sudo umount /dev/"$dev" && tune2fs /dev/"$dev" -U random; }
function rip_audio () { output="${1%.*}-ripped.${1##*.}"; mplayer -ao pcm -vo null -vc dummy -dumpaudio -dumpfile "$output" "$1"; }
function slugify () { echo "$*" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr '[:upper:]' '[:lower:]'; }
function vim_encoding_sample () { vim 'https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt'; }

function test_slugify () {
    # some punctuation
    test "$(slugify ',.;:_-+─=ºª¡!"·$%&/()[]{}¿?|@#~½¬')" == "oa-1-2" &&
    # some non-ascii charcters
    test "$(slugify 'áÁàÀăĂâÂåÅäÄąĄæÆćĆčČçÇđĐéÉèÈėĖęĘğíÍîÎïÏįĮıňŇñÑóÓòÒöÖőŐõÕøØšŠşŞţŢúÚüÜűŰųŲūŪýÝžŽ')" == "aaaaaaaaaaaaaaaeaeccccccddeeeeeeeegiiiiiiiiinnnnoooooooooooossssttuuuuuuuuuuyyzz";
}

# https://github.com/nvbn/thefuck
alias fuck='eval $(thefuck $(fc -ln -1))'

# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
alias j='jump'

# improved cd'ing
# examples:
# `..` go up one directory
# `.. 3` go up three directories
# `.. foo` go up to the most upper directory whose name is `foo`
function .. () {
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
function __cd () {
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
function __vim () {
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
            /usr/bin/vim "$fn" +"$ln"
        elif [[ -n "$*" ]]; then
            /usr/bin/vim "$@"
        else
            # edit last opened file on the last line
            /usr/bin/vim -c "normal '0"
        fi
    fi
}

function __cat () {
    if [ "$#" -eq 1 ] && [ -d "$1" ]; then
        ls "$1"
    elif [ "$#" -eq 0 ]; then
        /bin/cat
    else
        /bin/cat "$@"
    fi
}

function __df () {
    if command -v pydf; then
        pydf "$@"
    else
        /bin/df "$@"
    fi
}

function reattach () {
    if [ "$(/bin/cat /proc/sys/kernel/yama/ptrace_scope)" == "1" ]; then
        echo "ERROR: to allow non-root users to reattach a process in Ubuntu:"
        echo "  $ echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope"
    else
        if [ "$(jobs -p | wc -l)" -gt 1 ]; then
            echo "ERROR: more than one process in background"
        else
            PPIDBG="$(jobs -p)"
            CMD="$(jobs -l | awk '{ print substr($0, index($0, $4)) }')"
            disown
            tmux new -d -s "r_$PPIDBG" -n "$CMD"
            tmux send-keys -t "r_$PPIDBG" "reptyr $PPIDBG" ENTER
            tmux attach -t "r_$PPIDBG"
        fi
    fi
}

# to avoid `..` to be aliased by other scripts. this must be at the end of the
# file
function alias () {
    if [[ "$1" =~ \.\.=.+ ]]; then
        false
    else
        builtin alias "$@"
    fi
}
