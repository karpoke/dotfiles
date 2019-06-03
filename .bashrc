export DOTFILES_DIR="${BASH_SOURCE%/*}"

export CDPATH=:..:~:~/projects:$CDPATH
# http://mywiki.wooledge.org/BashFAQ/028

[ -f "$DOTFILES_DIR/.bash_aliases" ] && source "$DOTFILES_DIR/.bash_aliases"
[ -f "$DOTFILES_DIR/.jump.sh" ] && source "$DOTFILES_DIR/.jump.sh"
