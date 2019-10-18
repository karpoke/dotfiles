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
    keepassx \
    ncftp \
    oathtool \
    python-pip \
    shellcheck \
    silversearcher-ag \
    sqlite3 \
    thefuck \
    tig \
    tmux \
    tmuxinator \
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

read -p "Install fzf? [y/N] " yn
if [ "$yn" == "y" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    read -p "Install navi (requires fzf)? [y/N] " yn
    if [ "$yn" == "y" ]; then
        git clone https://github.com/denisidoro/navi ~/.navi
        cd ~/.navi
        sudo make install
    fi
fi

read -p "Install blsd? [y/N] " yn
if [ "$yn" == "y" ]; then
    bash <(curl -fL https://raw.githubusercontent.com/junegunn/blsd/master/install)
fi

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
test ! -e "${BASH_SOURCE%/*}/.agignore" && ln -s "${BASH_SOURCE%/*}/.agignore"
test ! -e "${BASH_SOURCE%/*}/.editorconfig" && ln -s "${BASH_SOURCE%/*}/.editorconfig"
test ! -e "${BASH_SOURCE%/*}/.i3" && ln -s "${BASH_SOURCE%/*}/.i3"
test ! -e "${BASH_SOURCE%/*}/.inputrc" && ln -s "${BASH_SOURCE%/*}/.inputrc"
test ! -e "${BASH_SOURCE%/*}/.gitconfig" && ln -s "${BASH_SOURCE%/*}/.gitconfig"
test ! -e "${BASH_SOURCE%/*}/.tmux.conf" && ln -s "${BASH_SOURCE%/*}/.tmux.conf"
# test ! -e "${BASH_SOURCE%/*}/.vimrc" && ln -s "${BASH_SOURCE%/*}/.vimrc"

grep -q "source ${BASH_SOURCE%/*}/.bashrc" ~/.bashrc || echo "source ${BASH_SOURCE%/*}/.bashrc" >> ~/.bashrc
