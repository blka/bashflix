#!/usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"
password="${1}"
if [ -z "${password}" ]; then
  echo "Password is mandatory!"
  echo ""
  echo "notes: the password will be used to install third-party software (run apt and pip3 with sudo)"
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
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  run-with-sudo apt-get update -y
  run-with-sudo apt-get install -y git curl software-properties-common build-essential libssl-dev
fi
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  run-with-sudo apt-get install -y software-properties-common
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  run-with-sudo apt-get install -y nodejs
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew upgrade node
  brew install npm
fi
echo "Preparing to install PIP3 ..."
if [[ "$OSTYPE" == "linux-gnu" ]]; then
 run-with-sudo apt-get -y update
 run-with-sudo apt-get install -y python3 python3-pip
elif [[ "$OSTYPE" == "darwin"* ]]; then
 brew upgrade python3
 brew upgrade python
 brew install python3
fi
echo "Preparing to install MPV ..."
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  run-with-sudo add-apt-repository -y ppa:mc3man/mpv-tests
  run-with-sudo apt-get -y update
  run-with-sudo apt-get install -y libxslt1-dev libxml2-dev
  run-with-sudo apt-get install -y mpv
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew update
  brew upgrade mpv
  brew install mpv
fi
run-with-sudo python3 -m pip install --upgrade pip
run-with-sudo python3 -m pip install --upgrade pirate-get
run-with-sudo python3 -m pip install --upgrade subliminal
# TODO: Install rarbgapi through pip when there's a stable package there
run-with-sudo git clone https://github.com/verybada/rarbgapi.git
cd rarbgapi
run-with-sudo python3 setup.py install
cd ..
run-with-sudo rm -r rarbgapi
run-with-sudo npm install npm@latest -g
run-with-sudo npm install -g peerflix
run-with-sudo npm install webtorrent-cli -g
run-with-sudo pip install git+https://github.com/rachmadaniHaryono/we-get
chmod +x ${script_directory}/bashflix.sh
run-with-sudo ln -fs ${script_directory}/bashflix.sh /usr/local/bin/bashflix
run-with-sudo echo >$HOME/.bashflix_history
