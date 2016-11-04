#!/bin/bash
 
echo "$1" | sudo -S apt update
echo "$1" | sudo -S apt install python3-pip -y
echo "$1" | sudo -S apt install libxslt1-dev -y
echo "$1" | sudo -S apt install libxml2-dev -y
echo "$1" | sudo -S pip3 install pirate-get
echo "$1" | sudo -S apt install npm -y
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
echo "$1" | sudo -S apt install nodejs -y
echo "$1" | sudo -S npm install -g peerflix
echo "$1" | sudo -S apt install python-pip -y
echo "$1" | sudo -S pip install --upgrade pip
echo "$1" | sudo -S pip install subliminal
echo "$1" | sudo -S add-apt-repository ppa:mc3man/mpv-tests -y
echo "$1" | sudo -S apt update && sudo apt install mpv -y
chmod u+x bashflix.sh

