#!/bin/sh

mkdir $HOME/.config
mkdir $HOME/.local/bin

CFG=$HOME/.config
CUR=$(pwd)

stow --adopt -vt $CUR/.config $CFG
ln -s $CUR/.zshenv $HOME/
ln -s $CUR/.tmux.conf $HOME/

git submodule add https://github.com/owpk/server-dots

cp scripts/* $HOME/.local/bin
