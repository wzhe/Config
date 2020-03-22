#! /usr/bin/env bash

DOTFILES=$HOME/.local/dotfiles


cp -R $HOME/.local/bin/. "$DOTFILES/bin"
cp -R $HOME/.local/etc/. "$DOTFILES/etc"

cd $DOTFILES

git add .

git commit -m "update config"

