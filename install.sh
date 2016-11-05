#!/usr/bin/env bash

#
# Bashflix Installer Mac OS and Ubuntu
#
# sudo removed in all the unnecessary commands
#

set -e

echo "Checking OS ..."
if [[ "$OSTYPE" != "linux-gnu" ]] && [[ "$OSTYPE" != "darwin"* ]]; then
  echo "Only Mac OS and Ubuntu are supported at the moment."
  exit 1
fi

echo "Checking bashflix requirements ..."

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Looking for Homebrew ..."
  if ! which brew &>/dev/null; then
    echo "Preparing to install Homebrew ..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

echo "Looking for NPM ..."
if ! which npm &>/dev/null; then
  node_version="7.0.0"
  echo "Preparing to install Node ${node_version} and NPM ..."
  git clone https://github.com/nodenv/nodenv.git ~/.nodenv
  cd ~/.nodenv && src/configure && make -C src
  git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
  cd ~/.nodenv && git pull
  cd ~/.nodenv/plugins/node-build && git pull
  ~/.nodenv/bin/nodenv install -s ${node_version}
  ~/.nodenv/bin/nodenv global ${node_version}
  export PATH="$HOME/.nodenv/bin":$PATH
  nodenv init - zsh
  nodenv rehash
  echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> .bashrc
fi

echo "Looking for PIP3 ..."
if ! which pip3 &>/dev/null; then
  echo "Preparing to install PIP3 ..."
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get -y update
    sudo apt-get install -y python3 python3-pip
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install python3
  fi
fi

echo "Preparing to install MPV ..."
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  sudo add-apt-repository -y ppa:mc3man/mpv-tests
  sudo apt-get -y update
  sudo apt-get install -y libxslt1-dev libxml2-dev
  sudo apt-get install -y mpv
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew update
  brew install mpv
fi

pip3 install --no-cache-dir -I -U --upgrade pip
pip3 install --upgrade pirate-get
pip3 install --upgrade subliminal

npm install -g peerflix

chmod u+x bashflix.sh
