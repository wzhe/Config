#!/bin/bash

source install-pre.sh

DOTFILES=~/.local/etc
TMUX=$HOME/.tmux
ZSH=$HOME/.antigen

printf "${BLUE} ➜  Starting Dotfiles...${NORMAL}\n"

ln -sf $DOTFILES/.zshenv $HOME/.zshenv
ln -sf $DOTFILES/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/.tmux.conf.local $HOME/.tmux.conf.local
ln -sf $DOTFILES/.markdownlint.json $HOME/.markdownlint.json

cp -n $DOTFILES/.npmrc $HOME/.npmrc
cp -n $DOTFILES/.gemrc $HOME/.gemrc
cp -n $DOTFILES/.zshrc.local $HOME/.zshrc.local

ln -sf $DOTFILES/.gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES/.gitconfig_global $HOME/.gitconfig_global
if [ "$SYSTEM" = "Darwin" ]; then
    cp -n $DOTFILES/.gitconfig_macOS $HOME/.gitconfig
elif [ "$OSTYPE" = "cygwin" ]; then
    cp -n $DOTFILES/.gitconfig_cygwin $HOME/.gitconfig
    ln -sf $OTFILES/.minttyrc $HOME/.minttyrc
else
    cp -n $DOTFILES/.gitconfig_linux $HOME/.gitconfig
fi

# Emacs Configs
printf "${BLUE} ➜  Installing Emacs Config...${NORMAL}\n"
if [ -d $HOME/.emacs.d ]; then
    printf "~/.emacs.d exist.\n"
else
    git clone --depth 1 -b master https://github.com/redguardtoo/emacs.d.git ~/.emacs.d
fi
ln -sf $DOTFILES/.custom.el $HOME/.custom.el

# Oh My Tmux
printf "${BLUE} ➜  Installing Oh My Tmux...${NORMAL}\n"
sync_repo gpakosz/.tmux $TMUX
ln -sf $TMUX/.tmux.conf $HOME/.tmux.conf

# printf "${BLUE} ➜  Installing Emacs...${NORMAL}\n"
# source $DOTFILES/install_emacs.sh

# printf "${BLUE} ➜  Installing misc...${NORMAL}\n"
# source $DOTFILES/install_misc.sh

printf "${BLUE} ➜  Installing zsh antigen ${NORMAL}\n"
#$INSTALL zsh-antigen
sudo mkdir -p /usr/share/zsh-antigen && sudo curl -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen
mkdir -p $ZSH
curl -L git.io/antigen > $ZSH/antigen.zsh.tmp && mv $ZSH/antigen.zsh.tmp $ZSH/antigen.zsh

# Entering zsh
printf "Done. Enjoy!\n"
if command -v zsh >/dev/null 2>&1; then
       if [ "$OSTYPE" != "cygwin" ] && [ "$SHELL" != "$(which zsh)" ]; then
           chsh -s $(which zsh)
           printf "${BLUE} You need to logout and login to enable zsh as the default shell.${NORMAL}\n"
       fi
       env zsh
else
    echo "${RED}Error: zsh is not installed${NORMAL}" >&2
    exit 1
fi
