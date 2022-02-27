#!/usr/bin/env bash

case $(uname -s) in
    Darwin)
        which -s brew
        if [[ $? != 0 ]] ; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew update
        brew install bash
        ;;
esac
bash -c "$(curl -s https://raw.githubusercontent.com/andretavare5/bashflix/master/generic_install.sh)"