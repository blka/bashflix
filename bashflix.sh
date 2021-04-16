#!/usr/bin/env bash
echo -n "
██████╗  █████╗ ███████╗██╗  ██╗███████╗██╗     ██╗██╗  ██╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║╚██╗██╔╝
██████╔╝███████║███████╗███████║█████╗  ██║     ██║ ╚███╔╝ 
██╔══██╗██╔══██║╚════██║██╔══██║██╔══╝  ██║     ██║ ██╔██╗ 
██████╔╝██║  ██║███████║██║  ██║██║     ███████╗██║██╔╝ ██╗
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝╚═╝  ╚═╝                                    
"
query="$1"
if [ -z "$1" ] || [ "$query" == "-h" ]; then
  echo "Bash script to watch movies and TV shows on Mac OS X and Linux, with subtitles, instantaneously. Just give the name, quickly grab your popcorn and have fun!"
  echo
  echo "Syntax: bashflix [-r|p|h] \"search query\" subtitles_language"
  echo "options:"
  echo "u     Update bashflix"
  echo "p     Previously watched"
  echo "h     Help"
  echo
  echo "Examples:" 
  echo "bashflix \"some movie title 1080p\""
  echo "bashflix \"some serie title s01e01\" pt"
  echo "bashflix -p"
  exit 0
fi
if [ "$query" == "-u" ]; then
  $(bash <(curl -fsSL https://raw.githubusercontent.com/0zz4r/bashflix/master/install.sh))
  exit 0
fi
if [ "$query" == "-p" ]; then
  echo "Previously watched:"
  echo "$(cat $HOME/.bashflix_history)"
  exit 0
else
  echo "$query" | cat - $HOME/.bashflix_history > temp && mv temp $HOME/.bashflix_history
fi
echo "Searching the best torrent..."
query="${query#\ }"
query="${query%\ }"
query="${query// /.}"
magnet=$(pirate-get -s SeedersDsc -0 -C 'echo "%s"' "${query}" | tail -n 1)
if [ -z $magnet ]; then
  echo "Could not find torrent for query ${query}." 
  echo "Please change the query."
  exit 1
else
  echo "Torrent found on The Pirate Bay: ${magnet}"
fi
# echo "${magnet}"
# if [[ ${magnet} == *"No results"* ]]; then
# if [[ ${magnet} != *"magnet"* ]]; then
#   magnet=$(we-get --search "${query}" --target yts -L | head -n 1)
#   echo "Torrent found on YTS: ${magnet}"
# fi 
# if [[ ${magnet} != *"magnet"* ]]; then
#   magnet=$(we-get --search "${query}" --target 1337x -L | head -n 1)
#   echo "Torrent found on 1337x: ${magnet}"
# fi
# if [[ ${magnet} != *"magnet"* ]]; then
#  magnet=$(rarbgapi --search-string "${query}" | tail -n 1 | sed -n 's/^.*magnet:?/magnet:?/p')
#  echo "Torrent found on RARBG: ${magnet}"
# fi
# if [[ ${magnet} != *"magnet"* ]]; then
#  magnet=$(we-get --search "${query}" --target eztv -L | head -n 1)
#  echo "Torrent found on EZTV: ${magnet}"
# fi
# if [[ ${magnet} != *"magnet"* ]]; then
#   echo "Could not find torrent for the query ${query}. Change the query."
#   exit 1
# fi
language=${2}
subtitle=""
if [ -n "${language}" ]; then
  echo "Searching the best subtitles..."
  torrent_name_param=$(awk -F "&" '{print $2}' <<< "$magnet")
  torrent_name_dirty=$(awk -F "=" '{print $2}' <<< "$torrent_name_param")
  torrent_name_raw=$(echo "$torrent_name_dirty" | sed -e 's/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g')
  torrent_name_escaped=$(echo -e "$torrent_name_raw")
  torrent_name=$(echo -e "$torrent_name_escaped")
  mkdir -p "/tmp/bashflix/${query}"
  languages=("${language}")
  languages+=("en")
  for language in ${languages[@]}; do
    subliminal download -l "$language" -d "/tmp/bashflix/${query}" "${torrent_name}"
    subtitle=$(find /tmp/bashflix/${query} -maxdepth 1 -name "*${language}*.srt" | head -1)
    if [ -n "$subtitle" ]; then
      echo "Found subtitle for language ${language}"
      #find /tmp/bashflix/${query} -maxdepth 1 -name "${language}.srt" | head -1 | xargs -I '{}' mv {} "/tmp/bashflix/${query}/${query}.${language}.srt"
      subtitle=$(find /tmp/bashflix/${query} -maxdepth 1 -name "${language}.srt" | head -1)
      #echo $subtitle
      break;
    fi
  done
fi
echo "Streaming ${torrent_name} with ${subtitle}..."
if [ -n "${subtitle}" ]; then
  peerflix ${magnet} --subtitles ${subtitle} --vlc -- --fullscreen 
else
  peerflix ${magnet} --vlc -- --fullscreen
fi
#if [ -n "${subtitle}" ]; then
#  webtorrent download ${magnet} --mpv -t ${subtitle}
#else
#  webtorrent download ${magnet} --mpv
#fi
rm -rf /tmp/bashflix/*
