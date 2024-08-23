#!/bin/sh

mkdir $HOME/.config
mkdir $HOME/.local/bin

CFG=$HOME/.config
mkdir $CFG 2> /dev/null
CUR=$(pwd)

stow --adopt -vt $CFG .config
ln -snf $CUR/.zshenv $HOME/
ln -snf $CUR/.tmux.conf $HOME/

git config user.name "$USER"
git config user.email "--auto--"

git submodule add https://github.com/owpk/server-dots
git submodule init

stow --adopt -vt $LOCAL_BIN scripts 

./server-dots/install.sh

# Создаем и переключаемся на новую ветку в основном проекте
git checkout -b "$USER"
