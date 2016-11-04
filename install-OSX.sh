#!/bin/bash
 
echo "$1" | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "$1" | brew install python3
echo "$1" | pip3 install pirate-get
echo "$1" | brew install npm
echo "$1" | npm install -g peerflix
echo "$1" | pip3 install subliminal
echo "$1" | brew install mpv
