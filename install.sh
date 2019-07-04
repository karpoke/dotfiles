#!/usr/bin/env sh

sudo apt install \
    dsh \
    highlight \
    htop \
    python-pip \
    silversearcher-ag \
    tmux \
    vim \
    virtualenvwrapper

pip install \
    ipython

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

echo "source ${BASH_SOURCE%/*}/.bashrc" >> ~/.bashrc
