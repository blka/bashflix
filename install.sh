#!/usr/bin/env bash

echo -n "
Welcome to

    ██████╗  █████╗ ███████╗██╗  ██╗███████╗██╗     ██╗██╗  ██╗
    ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║╚██╗██╔╝
    ██████╔╝███████║███████╗███████║█████╗  ██║     ██║ ╚███╔╝ 
    ██╔══██╗██╔══██║╚════██║██╔══██║██╔══╝  ██║     ██║ ██╔██╗ 
    ██████╔╝██║  ██║███████║██║  ██║██║     ███████╗██║██╔╝ ██╗
    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝╚═╝  ╚═╝

This script will attempt to install the following software:
* python
* pip
* npm
* nodejs
* vlc
* pirate-get
* subliminal
* peerflix

"

install_package() {
    PACINSTALL=false
    for i in "${@}"; do
        if ! $PACSEARCH | grep "^${i}$" > /dev/null 2>&1
        then
            echo "Installing ${i}"
            $PACMAN ${i} && PACINSTALL=true
        fi
    done
    if [[ "${PACINSTALL}" == true ]]
    then
        return 0
    else
        return 1
    fi
}

if [[ $(uname -s) == "Darwin" ]]
then
    KERNEL="Darwin"
    OS="macos"
elif [[ $(uname -s) == "Linux" ]]
then
    KERNEL="Linux"
    if [[ -f /etc/arch-release ]]
    then
        OS="arch"
    elif [[ -f /etc/debian_version ]]
    then
        OS="debian"
    elif [[ -f /etc/redhat-release ]]
    then
        OS="fedora"
    fi
else
    exit 1
fi

PYTHON3='python3'
PIP3='python3-pip'
NPM='npm'
NODE='nodejs'
VLC='VLC'
case $OS in
    macos)
        PYTHON3='python' # Includes pip3 on macOS
        NODE='node'
        VLC='--cask vlc'
        ;;
    arch)
        PYTHON3='python'
        PIP3='python-pip'
        ;;
    debian) ;;
    fedora) ;;
esac

if [[ "$OS" == "macos" ]]; then
    echo "Looking for Homebrew ..."
    if ! which brew &>/dev/null; then
        echo "Preparing to install Homebrew ..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        brew update
    fi
    PACMAN="brew install"
    PACSEARCH="brew list"
else
    declare -A osInfo;
    osInfo[/etc/redhat-release]='dnf --assumeyes install'
    osInfo[/etc/arch-release]='pacman -S --noconfirm'
    osInfo[/etc/gentoo-release]='emerge'
    osInfo[/etc/SuSE-release]='zypper in'
    osInfo[/etc/debian_version]='apt-get --assume-yes install'
    declare -A osSearch;
    osSearch[/etc/redhat-release]='dnf list installed'
    osSearch[/etc/arch-release]='pacman -Qq'
    osSearch[/etc/gentoo-release]="cd /var/db/pkg/ && ls -d */*| sed 's/\/$//'"
    osSearch[/etc/SuSE-release]='rpm -qa'
    osSearch[/etc/debian_version]='dpkg -l' # previously `apt list --installed`.  Can use `apt-cache search`.
    for f in "${!osInfo[@]}"
    do
        if [[ -f $f ]];then
            PACMAN="${osInfo[$f]}"
        fi
    done
    for s in "${!osSearch[@]}"
    do
        if [[ -f $s ]];then
            PACSEARCH="${osSearch[$s]}"
        fi
    done
    install_package "${PIP3}" "${NPM}"
fi

install_package "${PYTHON3}" "${NODE}" "${VLC}"

pip3 install --upgrade pirate-get
pip3 install --upgrade subliminal
npm install -g peerflix

cd /usr/local/bin/
curl -s https://raw.githubusercontent.com/0zz4r/bashflix/master/bashflix.sh -o bashflix
chmod +x bashflix
touch ~/.bashflix
