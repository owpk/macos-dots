#!/bin/sh

mkdir $HOME/.config
mkdir $HOME/.local/bin

CFG=$HOME/.config
CUR=$(pwd)

stow --adopt -vt $CUR/.config $CFG
ln -s $CUR/.zshenv $HOME/
ln -s $CUR/.tmux.conf $HOME/

git submodule add https://github.com/owpk/server-dots
git submodule init

cp scripts/* $HOME/.local/bin

./server-dots/install-wo-githooks.sh

# Название новой ветки
NEW_BRANCH="$(cat /proc/sys/kernel/hostname | awk '{print tolower($0)}')"

# Создаем и переключаемся на новую ветку в основном проекте
git checkout -b "$NEW_BRANCH"

# Проходим по каждому сабмодулю и создаем ветку с тем же именем
git submodule foreach --recursive '
    git checkout -b "$NEW_BRANCH"
'
