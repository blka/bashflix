#!/bin/bash
 
echo "$1" | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "$1" | sudo -S brew update
echo "$1" | sudo -S brew install python3-pip
echo "$1" | sudo -S brew install libxslt1-dev
echo "$1" | sudo -S brew install libxml2-dev
echo "$1" | sudo -S brew install python3
echo "$1" | sudo -S pip3 install pirate-get
echo "$1" | sudo -S brew install npm
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
echo "$1" | sudo -S brew install nodejs
echo "$1" | sudo -S npm install -g peerflix
echo "$1" | sudo -S brew install python-pip
echo "$1" | sudo -S pip install --upgrade pip
echo "$1" | sudo -S pip install subliminal
echo "$1" | sudo -S brew install mpv
chmod u+x bashflix.sh
