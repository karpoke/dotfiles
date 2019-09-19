#!/usr/bin/env bash

sudo apt install \
    bleachbit \
    convmv \
    dsh \
    etckeeper \
    fdupes \
    getmail4 \
    git \
    gnupg2 \
    highlight \
    htop \
    ipcalc \
    ncftp \
    oathtool \
    python-pip \
    shellcheck \
    silversearcher-ag \
    tig \
    tmux \
    vim \
    virtualenvwrapper

# customize by host
HOSTNAMES=("rpi")
if [[ "${HOSTNAMES[@]}" =~ $(hostname) ]]; then
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

# check before install this

# fzf: https://github.com/junegunn/fzf#installation
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install

# blsd: https://github.com/junegunn/blsd
# bash <(curl -fL https://raw.githubusercontent.com/junegunn/blsd/master/install)

# autoenv
# git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
# echo 'source ~/.autoenv/activate.sh' >> ~/.bashrc

# pivpn: http://www.pivpn.io/
# curl -L https://install.pivpn.io | bash
# pivpn add
# pivpn add nopass
# pivpn list

# transmission
# webui enabled: sudo ufw allow from 192.168.1.0/24 to any port 9091 proto tcp
# transmission-remote-cli --create-config


# config files
test ! -e "${BASH_SOURCE%/*}/.gitconfig" && ln -s "${BASH_SOURCE%/*}/.gitconfig"
test ! -e "${BASH_SOURCE%/*}/.tmux.conf" && ln -s "${BASH_SOURCE%/*}/.tmux.conf"

grep -q "source ${BASH_SOURCE%/*}/.bashrc" ~/.bashrc || echo "source ${BASH_SOURCE%/*}/.bashrc" >> ~/.bashrc
