#!/usr/bin/env bash

# admin
sudo apt install \
    bleachbit \
    convmv \
    ddrescue \
    deborphan \
    dsh \
    etckeeper \
    fdupes \
    filezilla \
    fonts-powerline \
    foremost \
    fswebcam \
    getmail4 \
    git \
    gnupg2 \
    highlight \
    htop \
    iftop \
    ipcalc \
    keepassx \
    lnav \
    locate \
    mailutils \
    ncftp \
    oathtool \
    pydf \
    python-pip \
    rdfind \
    reptyr \
    scalpel \
    shellcheck \
    silversearcher-ag \
    sqlite3 \
    sqlitebrowser \
    testdisk \
    thefuck \
    tig \
    tmux \
    tmuxinator \
    vim \
    virtualenvwrapper

# hpvc
sudo apt install \
    hydra \
    medusa \
    ncrack \
    nmap \
    patator

# customize by host
HOSTNAMES=("rpi")
if [[ "${HOSTNAMES[*]}" =~ $(hostname) ]]; then
    sudo apt install \
        ddclient \
        jdupes \
        transmission-daemon \
        transmission-remote-cli
fi

pip install --upgrade pip
pip install \
    ipython \
    pdbpp

ipython profile create

sudo etckeeper init
# http://etckeeper.branchable.com/
# sudo etckeeper commit "Reason for configuration change"
# sudo git -C /etc log

read -rp "Install fzf? [y/N] " yn
if [ "$yn" == "y" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    read -rp "Install navi (requires fzf)? [y/N] " yn
    if [ "$yn" == "y" ]; then
        git clone https://github.com/denisidoro/navi ~/.navi
        cd ~/.navi || exit
        sudo make install
    fi
fi

read -rp "Install blsd? [y/N] " yn
if [ "$yn" == "y" ]; then
    bash <(curl -fL https://raw.githubusercontent.com/junegunn/blsd/master/install)
fi

read -rp "Install autoenv? [y/N] " yn
if [ "$yn" == "y" ]; then
    git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
    echo 'source ~/.autoenv/activate.sh' >> ~/.bashrc
fi

# pivpn: http://www.pivpn.io/
# curl -L https://install.pivpn.io | bash
# pivpn add
# pivpn add nopass
# pivpn list

# transmission
# webui enabled: sudo ufw allow from 192.168.1.0/24 to any port 9091 proto tcp
# transmission-remote-cli --create-config


# config files
DOTFILES_DIR="$(readlink -f "${BASH_SOURCE%/*}")"
test ! -e "${DOTFILES_DIR}/.agignore" && ln -s "${DOTFILES_DIR}/.agignore ~/.agignore"
test ! -e "${DOTFILES_DIR}/.editorconfig" && ln -s "${DOTFILES_DIR}/.editorconfig ~/.editorconfig"
test ! -e "${DOTFILES_DIR}/.i3" && ln -s "${DOTFILES_DIR}/.i3 ~/.i3"
test ! -e "${DOTFILES_DIR}/.inputrc" && ln -s "${DOTFILES_DIR}/.inputrc ~/.inputrc"
test ! -e "${DOTFILES_DIR}/.gitconfig" && ln -s "${DOTFILES_DIR}/.gitconfig ~/.gitconfig"
test ! -e "${DOTFILES_DIR}/.tmux.conf" && ln -s "${DOTFILES_DIR}/.tmux.conf ~/.conf"
test ! -e "${DOTFILES_DIR}/.vimrc" && ln -s "${DOTFILES_DIR}/.vimrc ~/.vimrc"

# vim plugins
# Install Vudle:  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Reload source:  :so %
# Install them:   :PluginInstall
# Install YCM:    cd ~/.vim/bundle/YouCompleteme && python3 install.py

grep -q "source ${DOTFILES_DIR}/.bashrc" ~/.bashrc || echo "source ${DOTFILES_DIR}/.bashrc" >> ~/.bashrc
