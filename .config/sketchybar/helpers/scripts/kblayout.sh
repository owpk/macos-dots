#!/bin/bash

LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | \
    egrep -w 'KeyboardLayout Name' | \
    cut -d'=' -f2 | \
    tr -d '";.' | \
    awk '{ print tolower($1) }')

echo $LAYOUT 

