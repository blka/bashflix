#!/usr/bin/env bash

#set -x

case $(uname -s) in
    Darwin) # macOS
        which -s brew
        if [[ $? != 0 ]] ; then 
            echo "brew not installed. Installing it..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        echo "Updating bash... (macOS default version is 3.2)"
        HOMEBREW_NO_AUTO_UPDATE=1 brew install bash -q
        echo "Done!"
        ;;
esac
#bash -c "$(curl -s https://raw.githubusercontent.com/andretavare5/bashflix/master/generic_install.sh)"
bash -c "$(cat generic_install.sh)"
