#!/usr/bin/env bash

#
# Bashflix Installer Mac OS and Ubuntu
#
# sudo removed in all the unnecessary commands
#

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

run-with-sudo apt update
run-with-sudo apt install python3-pip -y
run-with-sudo apt install libxslt1-dev -y
run-with-sudo apt install libxml2-dev -y
run-with-sudo pip3 install pirate-get
run-with-sudo apt install npm -y
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
run-with-sudo apt install nodejs -y
run-with-sudo npm install -g peerflix
run-with-sudo apt install python-pip -y
run-with-sudo pip install --upgrade pip
run-with-sudo pip install subliminal
run-with-sudo add-apt-repository ppa:mc3man/mpv-tests -y
run-with-sudo apt update && sudo apt install mpv -y

chmod u+x bashflix.sh

run-with-sudo ln -fs $(pwd)/bashflix.sh /usr/local/bin/bashflix
