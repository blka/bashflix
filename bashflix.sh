#!/bin/bash

lang1="pt"
lang2="en"

get-subs () {
  subliminal download -l $1 ${name// /.}
}

# get magnet 
pirate-get -s SeedersDsc -0 -M $1

magnet=$(find . -maxdepth 1 -name "*.magnet" | head -1)
name=${magnet:2:-7}

# get subtitles
get-subs ${lang1}

sub=$(find . -maxdepth 1 -name "*.srt" | head -1)

# try to search in english if portuguese not found
if [${sub} = ""]; then
  get-subs ${lang2}
  sub=$(find . -maxdepth 1 -name "*.srt" | head -1)
fi

# get magnet again to peerflix stream
pirate-get -s SeedersDsc -0 -C "peerflix \"%s\" -g -t ${sub:2}" $1

# remove created files
rm *.srt && rm *.magnet
