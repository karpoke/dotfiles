#!/usr/bin/env bash

sudo apt install \
    dsh \
    fdupes \
    git \
    highlight \
    htop \
    ipcalc \
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
        jdupes
fi

pip install --upgrade pip
pip install \
    ipython \
    pdbpp

ipython profile create

# check before install this

# fzf: https://github.com/junegunn/fzf#installation
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install

# blsd: https://github.com/junegunn/blsd
# bash <(curl -fL https://raw.githubusercontent.com/junegunn/blsd/master/install)

# autoenv
# git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
# echo 'source ~/.autoenv/activate.sh' >> ~/.bashrc

grep -q "source ${BASH_SOURCE%/*}/.bashrc" ~/.bashrc || echo "source ${BASH_SOURCE%/*}/.bashrc" >> ~/.bashrc
