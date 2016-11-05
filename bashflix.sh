#!/usr/bin/env bash

lang1="pt"
lang2="en"

get-subs () {
  subliminal download -l $1 ${name// /.} 
}

# get magnet 
pirate-get -s SeedersDsc -0 -M $1

#pirate-get -s SeedersDsc -0 -C "echo \"%s\"" $1 |
#  while IFS= read -r line
#  do
#    echo "$line" > magnet.txt
#  done

#value=$(<magnet.txt)
#value2=$(awk -F "&" '{print $2}' <<< "$value")
#value3=$(awk -F "=" '{print $2}' <<< "$value2")
#value4=$(echo "$value3" | sed -e 's/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g' | xargs echo -e)

magnet=$(find . -maxdepth 1 -name "*.magnet" | head -1)
name=${magnet:2:-7}
#name=${value4}

# get subtitles
get-subs ${lang1}

sub=$(find . -maxdepth 1 -name "*.srt" | head -1)

# try to search in english if portuguese not found
if [ -z "$sub" ]; then
  get-subs ${lang2}
  sub=$(find . -maxdepth 1 -name "*.srt" | head -1)
fi

sub2=$(echo "$sub" | sed -re 's/[()]//g')
sub3=${sub2:2}
mv ${sub:2} ${sub3}

# get magnet again to peerflix stream
pirate-get -s SeedersDsc -0 -C "peerflix \"%s\" -k -t ${sub3}" $1

# remove created files
rm *.srt && rm *.magnet && rm magnet.txt
