#!/bin/bash

source install-pre.sh

DOTFILES=~/.local/etc
TMUX=$HOME/.tmux
ANTIGEN=$HOME/.antigen
VIMCONFIG=$HOME/.local/vim

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

# vim Configs
printf "${BLUE} ➜  Installing vim Config...${NORMAL}\n"
sync_repo wzhe/vim-init $VIMCONFIG
# source vimrc.vim
touch ~/.vimrc
sed -i "\:$VIMCONFIG/init.vim:d" ~/.vimrc
echo "source $VIMCONFIG/init.vim" >> ~/.vimrc

# Emacs Configs
printf "${BLUE} ➜  Installing chemacs Config...${NORMAL}\n"
sync_repo plexus/chemacs ~/chemacs
~/chemacs/install.sh
ln -sf $DOTFILES/.emacs-profiles.el $HOME/.emacs-profiles.el

printf "${BLUE} ➜  Installing Emacs Config doom-emacs...${NORMAL}\n"
sync_repo hlissner/doom-emacs ~/doom-emacs
ln -sf $DOTFILES/doom $HOME/.config/doom

printf "${BLUE} ➜  Installing Emacs Config chenbin-emacs...${NORMAL}\n"
sync_repo redguardtoo/emacs.d ~/chenbin-emacs
ln -sf $DOTFILES/.custom.el $HOME/.custom.el

printf "${BLUE} ➜  Installing Emacs Config Centaur-emacs...${NORMAL}\n"
sync_repo redguardtoo/emacs.d ~/centaur-emacs

# Oh My Tmux
printf "${BLUE} ➜  Installing Oh My Tmux...${NORMAL}\n"
sync_repo gpakosz/.tmux $TMUX
ln -sf $TMUX/.tmux.conf $HOME/.tmux.conf

# printf "${BLUE} ➜  Installing Emacs...${NORMAL}\n"
# source $DOTFILES/install_emacs.sh

# printf "${BLUE} ➜  Installing misc...${NORMAL}\n"
# source $DOTFILES/install_misc.sh

printf "${BLUE} ➜  Installing Antigen...${NORMAL}\n"
#$INSTALL zsh-antigen
sync_repo zsh-users/antigen $ANTIGEN

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
