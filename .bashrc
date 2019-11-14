# http://mywiki.wooledge.org/BashFAQ/028
DOTFILES_DIR="$(readlink -f "${BASH_SOURCE%/*}")"
export DOTFILES_DIR
DOCKERIZED_APPS_DIR="$(readlink -f "$DOTFILES_DIR/../dockerize")"
export DOCKERIZED_APPS_DIR

export CDPATH=:..:~:~/projects:$CDPATH
export EDITOR=/usr/bin/vim
export HISTSIZE=20000000
export HISTFILESIZE=$HISTSIZE
export MANPAGER='less -s -M +Gg -X'
export PATH=$PATH:$DOCKERIZED_APPS_DIR

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# https://github.com/junegunn/fzf/
# https://www.mankier.com/1/fzf
# https://github.com/junegunn/blsd
export FZF_DEFAULT_OPTS='--height 40% --border --inline-info'
if command -v ag > /dev/null; then
    AG_VERSION=$(ag --version | head -1 | awk '{print $3}')
    if [ "$AG_VERSION" == "0.31.0" ]; then
        PATH_TO_AGIGNORE_OPT="--path-to-agignore '$DOTFILES_DIR/.agignore'"
    else
        PATH_TO_AGIGNORE_OPT="--path-to-ignore '$DOTFILES_DIR/.agignore'"
    fi
    export FZF_CTRL_T_COMMAND="ag --hidden $PATH_TO_AGIGNORE_OPT -g ''"
fi
command -v highlight > /dev/null && export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
test -z "$FZF_CTRL_T_OPTS" && export FZF_CTRL_T_OPTS='--preview "head -200 {}"'
command -v pbcopy > /dev/null && export FZF_CTRL_T_OPTS="$FZF_CTRL_T_OPTS --bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'"
command -v blsd > /dev/null && export FZF_ALT_C_COMMAND='blsd'
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS='--sort --exact --preview "echo {}" --preview-window down:3:hidden:wrap --bind "?:toggle-preview"'

command -v direnv > /dev/null && eval "$(direnv hook bash)"
# export VIRTUALENVWRAPPER_SCRIPT=/usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

[ -f "$DOTFILES_DIR/.bash_aliases" ] && source "$DOTFILES_DIR/.bash_aliases"
[ -f "$DOTFILES_DIR/jump.sh" ] && source "$DOTFILES_DIR/jump.sh"
[ -f "$DOTFILES_DIR/git_custom_prompt" ] && source "$DOTFILES_DIR/git_custom_prompt"
[ -f "$DOTFILES_DIR/.less_termcap" ] && source "$DOTFILES_DIR/.less_termcap"
