#!/usr/bin/env bash

set -x

case $(uname -s) in
    Darwin)
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install bash
        ;;
esac
bash -c "$(curl -s https://raw.githubusercontent.com/andretavare5/bashflix/master/generic_install.sh)"