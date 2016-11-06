#!/usr/bin/env bash

#
# Bashflix Installer Mac OS and Ubuntu
#
# sudo removed in all the unnecessary commands
#

set -e

password="${1}"

if [ -z "${password}" ]; then
  echo "Password is mandatory!"
  echo ""
  echo "usage: $0 <password>"
  echo ""
  echo "notes: the password will be used to run apt-get and pip3 with sudo"
  echo ""
  echo -n "Insert your password: "
  read -s password
  echo ""
fi

run-with-sudo() {
  echo "${password}" | sudo -S ${@}
}

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
    brew install git
  fi
else 
  if [[ "$OSTYPE" != "linux-gnu" ]]; then
    run-with-sudo apt-get install -y git
  fi
fi

echo "Looking for NPM ..."
if ! which npm &>/dev/null; then
  node_version="7.0.0"
  echo "Preparing to install Node ${node_version} and NPM ..."
  [[ ! -d "${HOME}/.nodenv" ]] && git clone https://github.com/nodenv/nodenv.git ${HOME}/.nodenv
  cd ${HOME}/.nodenv && src/configure && make -C src
  [[ ! -d "${HOME}/.nodenv/plugins/node-build" ]] && git clone https://github.com/nodenv/node-build.git ${HOME}/.nodenv/plugins/node-build
  cd ${HOME}/.nodenv && git pull
  cd ${HOME}/.nodenv/plugins/node-build && git pull

  export PATH="$HOME/.nodenv/bin:$PATH"
  nodenv install -s ${node_version}
  nodenv global ${node_version}

  nodenv init - zsh
  nodenv rehash

  echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ${HOME}/.bashrc
  echo 'eval "$($HOME/.nodenv/bin/nodenv init - zsh)"' >> ${HOME}/.bashrc
fi

echo "Looking for PIP3 ..."
if ! which pip3 &>/dev/null; then
  echo "Preparing to install PIP3 ..."
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    run-with-sudo apt-get -y update
    run-with-sudo apt-get install -y python3 python3-pip
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install python3
  fi
fi

echo "Preparing to install MPV ..."
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  run-with-sudo add-apt-repository -y ppa:mc3man/mpv-tests
  run-with-sudo apt-get -y update
  run-with-sudo apt-get install -y libxslt1-dev libxml2-dev
  run-with-sudo apt-get install -y mpv
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew update
  brew install mpv
fi

run-with-sudo pip3 install --no-cache-dir -I -U --upgrade pip
run-with-sudo pip3 install --upgrade pirate-get
run-with-sudo pip3 install --upgrade subliminal

npm install -g peerflix

chmod u+x bashflix.sh
