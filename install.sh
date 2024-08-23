#!/bin/sh

TERM_UTILS="server-dots"
CFG=$HOME/.config
LOCAL_BIN=$HOME/.local/bin

mkdir $LOCAL_BIN 2> /dev/null
mkdir $CFG 2> /dev/null

CUR=$(pwd)

stow --adopt -vt $CFG .config
ln -snf $CUR/.zshenv $HOME/
ln -snf $CUR/.tmux.conf $HOME/

git config user.name "$USER"
git config user.email "--auto--"

git submodule add https://github.com/owpk/$TERM_UTILS
git submodule init

stow --adopt -vt $LOCAL_BIN scripts 

# Создаем и переключаемся на новую ветку в основном проекте
git checkout -b "$USER"

cd $TERM_UTILS
./install.sh

