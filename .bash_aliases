__cd () {
    # examples:
    # `..` go up one directory
    # `.. 3` go up three directories
    # `.. foo` go up to the most upper directory whose name is `foo`
    local pwd="$PWD"
    if [[ -z "$1" ]] || [[ "$1" =~ [0-9]+ ]]; then
        let n="${1:-1}"
        let path="."
        while [ $n -gt 0 -a "$PWD" != "/" ]; do
            path="$path/.."
            n=$((n-1))
        done
        cd "$path"
    else
        cd "${PWD/$1*/$1}"
    fi
    OLDPWD="$pwd"
}
alias ..=__cd
