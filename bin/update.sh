#! /usr/bin/env bash

DOTFILES=$HOME/.local/dotfiles

cp $HOME/.local/bin/* "$DOTFILES/bin"
cp $HOME/.local/etc/* "$DOTFILES/etc"

cd $DOTFILES

git add .

git commit -m "update config"
