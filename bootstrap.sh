#! /usr/bin/env bash

ETC=~/.local/etc
BIN=~/.local/bin
VIMCONFIG=~/.local/vim
mkdir -p $ETC
mkdir -p $BIN
mkdir -p $VIMCONFIG

# git clone respository
cd ~/.local/

if [ -d vim]; then
    cd vim
    git pull
	cd ..
else
    git clone git@github.com:wzhe/vim-init.git vim
fi

if [ -d dotfiles ]; then
    cd dotfiles
    git pull
else
    git clone git@github.com:wzhe/Config.git dotfiles
    cd dotfiles
fi

cp -rf etc/* $ETC/
cp -rf bin/* $BIN/
cp bootstrap.sh $BIN/

# setup lemonade
# TODO check sys_type
sys_type=linux_amd64
mkdir -p ~/.config

# source init.sh
sed -i "\:$ETC/init.sh:d" ~/.bashrc
echo ". $ETC/init.sh" >> ~/.bashrc
. ~/.bashrc

# source vimrc.vim
touch ~/.vimrc
sed -i "\:$VIMCONFIG/init.vim:d" ~/.vimrc
echo "source $VIMCONFIG/init.vim" >> ~/.vimrc

# source tmux.conf
touch ~/.tmux.conf
sed -i "\:$ETC/tmux.conf:d" ~/.tmux.conf
echo "source $ETC/tmux.conf" >> ~/.tmux.conf

# update git config
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global core.quotepath false
