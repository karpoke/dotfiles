#!/bin/bash

# some useful sources
# https://github.com/Bash-it/bash-it/tree/master/aliases/available
# https://github.com/ohmybash/oh-my-bash/tree/master/aliases
# https://www.commandlinefu.com/commands/browse
# https://twitter.com/climagic

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


# to avoid `..` to be aliased by other scripts
alias () {
    if [[ "$1" =~ \.\.=.+ ]]; then
        false
    else
        builtin alias "$@"
    fi
}

# shortcuts
alias apd='apt list --upgradable'
alias apg='sudo apt upgrade'
alias aph='apt show'
alias api='sudo apt install'
alias app='sudo apt autoremove --purge && sudo apt clean'
alias aps='apt search'
alias apu='sudo apt update'
alias apr='sudo apt purge'
# add autocompletion for aliases
complete -c apd apg aph api apr

alias ag='ag --hidden'
alias bc='bc -l'           # --mathlib
alias cp='cp -i'           # --interactive
alias curl='curl -s -C-'   # --silent --continue-at automatically
alias dmesg='dmesg -wT'    # --follow --ctime
alias ln='ln -v'           # --verbose
alias ls='ls --color=tty'  # --color when tty
alias mkdir='mkdir -pv'    # --parent --verbose
alias mv='mv -iv'          # --interactive --verbose
alias ping='ping -c 4'     # count
alias rm='rm -Iv'          # prompt once, --verbose
alias rsync='rsync -hv'    #  --human-readable --verbose
alias ssh='ssh -C'         # requests compression
alias wget='wget -c'       # --continue
alias xargs='xargs -r'     # --no-run-if-empty

# shellcheck disable=SC2139 disable=SC1083
alias best_ubuntu_server="curl -s http://mirrors.ubuntu.com/mirrors.txt | xargs -n1 -I {} sh -c 'echo $(curl -r 0-102400 -s -w %{speed_download} -o /dev/null {}/ls-lR.gz) {}' | sort -gr | head -3 | awk '{ print $2 }'"
alias capture_desktop='ffmpeg -video_size 1024x768 -framerate 25 -f x11grab -i :0.0+100,200 output.mp4'
alias ch644='find . -type f -exec chmod 644 {} \;'
alias ch755='find . -type d -exec chmod 755 {} \;'
alias ch664='find . -type f -exec chmod 664 {} \;'
alias ch775='find . -type d -exec chmod 775 {} \;'
alias fakeroot_without_fakeroot='unshare -r --fork --pid unshare -r --fork --pid --mount-proc bash'
alias sch644='sudo find . -type f -exec chmod 644 {} \;'
alias sch755='sudo find . -type d -exec chmod 755 {} \;'
alias sch664='sudo find . -type f -exec chmod 664 {} \;'
alias sch775='sudo find . -type d -exec chmod 775 {} \;'
alias clock='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
alias cls='clear'
alias cpv='rsync -ah --info=progress2'
alias delete_empty_lines='sed -i "/^\s*$/d"'
alias dkelc='docker exec -it $(dklcid) bash --login'
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'
alias dkrmid='docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi'
alias full_fs_json='sudo tree -Jhfpug /'
alias get_developer_excuses='curl -s  http://developerexcuses.com/ | grep nofollow | grep -Eo ">[^<]+" | cut -b 2-'
alias hide_last='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'
alias http_server='python -m SimpleHTTPServer'
alias last_update='stat -c %y /var/cache/apt/pkgcache.bin'
alias lt='ls --human-readable --size -1 -S --classify -r'
alias make1mb='truncate -s 1m ./1MB.dat'
alias maze='tr -cd \\\\/ </dev/urandom | fold -w $(tput cols) | sed -e "s#/#╱#g;s#\\\\#╲#g"'
# shellcheck disable=SC2142
alias mnt='mount | awk -F'\'' '\'' '\''{ printf "%s\t%s\n",$1,$3; }'\'' | column -t | egrep ^/dev/ | sort'
alias myip='curl -A firefox -s https://www.ignaciocano.com/ip'
alias num_csv_columns="awk -F, 'NR==1{print NF}'"
alias pbpaste='xclip -selection clipboard -o'
alias pbcopy='perl -pe "chomp if eof" | xclip -selection clipboard; pbpaste | xclip -selection primary; pbpaste | xclip -selection secondary'
alias perm='stat --printf "%a %n \n"'
alias pip_upgrade_outdated='pip list --outdated --format=freeze | grep -v "^\-e" | cut -d = -f 1 | xargs -n1 pip install -U'
alias ppjson='python -m json.tool'
alias proxy_ssh_start='ssh -fN proxy_ssh'
alias proxy_ssh_stop='ssh -O exit proxy_ssh'
alias proxy_ssh_status='ssh -O check proxy_ssh'
# shellcheck disable=SC2142
alias remove_duplicated_lines='awk '\''!x[$0]++'\'''
alias smtp_debug_server='python -m smtpd -n -c DebuggingServer localhost:1025'
alias timewatch='(trap '\''kill -sSIGHUP $PPID'\'' SIGINT && echo "Stop it with ^D" && time read)'
alias upgrade_fzf='cd ~/.fzf && git pull && ./install'
alias what_the_commit="curl -s whatthecommit.com | grep '<p>' | sed 's/<p>//g'"
alias wifi_passwords='sudo egrep "psk=" /etc/NetworkManager/system-connections/*'


# https://cirw.in/blog/bracketed-paste
# http://thejh.net/misc/website-terminal-copy-paste
alias enable_bracketed_paste_mode='printf "\e[?2004h"'
alias disable_bracketed_paste_mode='printf "\e[?2004l"'

alias cat=__cat
alias cd=__cd
alias df=__df
alias grep=__grep
alias last=__last
alias vim=__vim

# one-liner utilities
alert_when_site_is_up () { while ! curl -m 60 "$1"; do sleep 60; done; play -q "$DOTFILES_DIR/hostdown.wav" 2>/dev/null; }
bak () { [ -r "$1" ] && mv "$1"{,.bak}; }
check_http_https_ports () { ss -o state established '( sport = :http or sport = :https )'; }
check_root () { if [ "$(id -u)" -ne 0 ]; then echo "ERROR: You must be root user to run this program"; exit; fi; }
clean_repeated_history () { tac "$HISTFILE" | awk '!x[$0]++' | tac | sponge "$HISTFILE" && history -c && history -r; }
# another way of removing dupes keeping the last: history | sort -k2 -k1,1nr | uniq -f1 | sort -n | cut -f2
cmd2img () { convert -font courier -pointsize 12 -background black -fill white label:"$("$@")" -trim output.png; }
# https://gist.github.com/kamermans/1076290
fail2ban_client_status () { fail2ban-client status | tail -1 | awk -F: '{print $2}' | sed 's/,//g' | xargs -n1 fail2ban-client status; }
ffind () { find . -iname "*$**"; }
hr(){ printf "%0$(tput cols)d" | tr 0 "${1:-_}"; }
http_compression () { curl -s -I -H "Accept-Encoding: br,gzip,deflate" -A "firefox" "$1" | grep -i "Content-Encoding"; }
http_status () { curl -s -o /dev/null -w "%{http_code}" -A "firefox" "$1"; }
ipinfo () { curl -s "http://ipinfo.io/$1"; }
list_units_failed () { sudo systemctl list-units --failed; }
lnp () { mkdir -p "$(dirname "$2")" && ln -s "$1" "$2"; }
mping(){ command ping "$1" | awk -F[=\ ] '/me=/{t=$(NF-1);f=3000-14*log(t^20);c="play -q -n synth 1 pl " f;print $0;system(c)}'; }
pyimport () { python -c "import $1"; }
pypath () { python -c "import os, $1; print(os.path.dirname($1.__file__))"; }
pysslcertspath () { python -c "import ssl; print(ssl.get_default_verify_paths())"; }
random_string () { local -i LEN="${1:-12}"; </dev/urandom tr -dc '[:print:]' | tr -d ''\''\\"' | head -c "$LEN"; }
# another way: </dev/urandom | openssl sha1 | awk '{print $2}'
random_uuid_to_dev () { dev="$1"; sudo umount /dev/"$dev" && tune2fs /dev/"$dev" -U random; }
rip_audio () { output="${1%.*}-ripped.${1##*.}"; mplayer -ao pcm -vo null -vc dummy -dumpaudio -dumpfile "$output" "$1"; }
show_fonts () { mkdir -p /tmp/fonts; convert -list font | awk -F: '/^\ *Font: /{print substr($NF,2)}' | while read -r font ; do convert -size 600x400 xc: -annotate +10+10 "$font" -gravity center -pointsize 42 -font "$font" -annotate +0+0 'ABCDEF\nabcdef\n012345\n!@$%%' -flatten "/tmp/fonts/$font".png ; done; }
slugify () { echo "$*" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr '[:upper:]' '[:lower:]'; }
t () { if tmux list-sessions >/dev/null; then tmux attach; else tmux; fi; }
# perl do not convert ( and ) to %28 and %29
# perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$*"
uri_encode () { python -c "from __future__ import print_function; import urllib; print(urllib.quote('''$*'''), end='')"; }
vim_encoding_sample () { vim 'https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt'; }
youtube-dl-audio () { youtube-dl --quiet --format best --extract-audio --audio-format best --metadata-from-title "%(artist)s - %(title)s" --output "%(title)s.%(ext)s" "$1"; }
which_package () { dpkg -S "$(which "$1")"; }

test_slugify () {
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
.. () {
    local n
    local oldpwd
    local path
    local re

    oldpwd="$PWD"
    re='^[0-9]+$'
    if [[ -z "$1" ]] || [[ "$1" =~ ^[0-9]+$ ]]; then
        n="${1:-1}"
        path="."
        while [ "$n" -gt 0 ] && [ "$PWD" != "/" ]; do
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
__cd () {
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
# appropiate commands. also make it easier open files into the
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
    elif [[ "$fn" =~ /etc/sudoers.d/.* ]]; then
        sudo visudo -f "$fn"
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

__cat () {
    if [ "$#" -eq 1 ] && [ -d "$1" ]; then
        ls "$1"
    elif [ "$#" -eq 0 ]; then
        /bin/cat
    else
        /bin/cat "$@"
    fi
}

__df () {
    if command -v pydf; then
        pydf "$@"
    else
        /bin/df "$@"
    fi
}

__grep () {
    /bin/grep --color -i --exclude-dir={.bzr,CVS,.git,.hg,.svn} "$@" | /bin/grep -v grep
}

__last () {
    # show `last` results in reverse order
    /usr/bin/last "$@" | tac
}

reattach () {
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

# explain.sh https://www.tecmint.com/explain-shell-commands-in-the-linux-shell/
explain () {
    if [ "$#" -eq 0 ]; then
        while read -rp "Command: " cmd; do
            curl -Gs "https://www.mankier.com/api/explain/?cols=$(tput cols)" --data-urlencode "q=$cmd"
        done
        echo "Bye!"
    elif [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols=$(tput cols)" --data-urlencode "q=$1"
    else
        echo "Usage"
        echo "explain                  interactive mode."
        echo "explain 'cmd -o | ...'   one quoted command to explain it."
    fi
}

