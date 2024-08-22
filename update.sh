#!/bin/sh

git config diff.submodule log
git config -f .gitmodules submodule.server-dots.branch main

git pull origin main --strategy-option=ours
git submodule update --remote server-dots 
