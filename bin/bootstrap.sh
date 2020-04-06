#! /usr/bin/env bash

#set -x

ETC=~/.local/etc
BIN=~/.local/bin
VIMCONFIG=~/.local/vim

mkdir -p $ETC
mkdir -p $BIN

# git clone respository
cd ~/.local/

if [ -d dotfiles ]; then
    cd dotfiles
    git pull
else
    git clone https://github.com/wzhe/Config.git dotfiles
    cd dotfiles
fi

yes | cp -R etc/. $ETC/
#yes | cp -R bin/. $BIN/

chmod +x $BIN/*

mkdir -p ~/.config

# source init.sh
sed -i "\:$ETC/init.sh:d" ~/.bashrc
echo ". $ETC/init.sh" >> ~/.bashrc
. ~/.bashrc

# update git config
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global core.quotepath false
git config --global user.name wzhe
git config --global user.email ahuwang@163.com

cd install
./install-basic.sh
./install-dotfile.sh
