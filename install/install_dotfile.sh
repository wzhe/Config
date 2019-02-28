#!/bin/bash

printf "${BLUE} ➜  Starting Dotfiles...${NORMAL}\n"

ln -sf $DOTFILES/.zshenv $HOME/.zshenv
ln -sf $DOTFILES/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/.tmux.conf.local $HOME/.tmux.conf.local
ln -sf $DOTFILES/.markdownlint.json $HOME/.markdownlint.json

cp -n $DOTFILES/.npmrc $HOME/.npmrc
cp -n $DOTFILES/.gemrc $HOME/.gemrc
cp -n $DOTFILES/.zshrc.local $HOME/.zshrc.local
mkdir -p $HOME/.pip; cp -n $DOTFILES/.pip.conf $HOME/.pip/pip.conf

ln -sf $DOTFILES/.gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES/.gitconfig_global $HOME/.gitconfig_global
if [ "$SYSTEM" = "Darwin" ]; then
    cp -n $DOTFILES/.gitconfig_macOS $HOME/.gitconfig
elif [ "$OSTYPE" = "cygwin" ]; then
    cp -n $DOTFILES/.gitconfig_cygwin $HOME/.gitconfig
    ln -sf $DOTFILES/.minttyrc $HOME/.minttyrc
else
    cp -n $DOTFILES/.gitconfig_linux $HOME/.gitconfig
fi

# Emacs Configs
printf "${BLUE} ➜  Installing Centaur Emacs...${NORMAL}\n"
sync_repo wzhe/.emacs.d $EMACSD
ln -sf $DOTFILES/.vimrc $HOME/.vimrc

# Oh My Tmux
printf "${BLUE} ➜  Installing Oh My Tmux...${NORMAL}\n"
sync_repo gpakosz/.tmux $TMUX
ln -sf $TMUX/.tmux.conf $HOME/.tmux.conf


printf "${BLUE} ➜  Installing Emacs...${NORMAL}\n"
source $DOTFILES/install_emacs.sh

printf "${BLUE} ➜  Installing misc...${NORMAL}\n"
source $DOTFILES/install_misc.sh

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
