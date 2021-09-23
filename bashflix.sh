#!/usr/bin/env bash

case $1 in

  "-h" | "--help" | "")
    echo -n "
    ██████╗  █████╗ ███████╗██╗  ██╗███████╗██╗     ██╗██╗  ██╗
    ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║╚██╗██╔╝
    ██████╔╝███████║███████╗███████║█████╗  ██║     ██║ ╚███╔╝ 
    ██╔══██╗██╔══██║╚════██║██╔══██║██╔══╝  ██║     ██║ ██╔██╗ 
    ██████╔╝██║  ██║███████║██║  ██║██║     ███████╗██║██╔╝ ██╗
    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝╚═╝  ╚═╝                                    
    "
    echo "Bash script to watch movies and TV shows on Mac OS X and Linux, with subtitles, instantaneously. Just give the name, quickly grab your popcorn and have fun!"
    echo
    echo "Syntax: bashflix [option] OR [\"movie / series sXXeYY\" [subtitles_language]]"
    echo "options:"
    echo "-u, --update                Update bashflix"
    echo "-p, --previously-watched    Previously watched"
    echo "-s, --select-torrent        Select torrent"
    echo 
    echo "Tips:"
    echo "* Stuck? \"ctrl+c\" and change the search query;"
    echo "* Want to select a different result? \"bashflix -s\";"
    echo "* Subtitles not synced? Use \"j\" to speed it up or \"h\" to delay it;"
    echo "* Stopping? \"space\" to PAUSE, wait a few minutes and \"space\" to PLAY;"
    echo "* What did I watch? \"bashflix -p\" to see which episode to watch next;"
    echo "* Need help? \"bashflix -h\" shows how to use it;"
    echo "* From time to time, use \"bashflix -u\" to update bashflix."
    exit 0
    ;;

  "-u" | "--update")
    $(bash <(curl -fsSL https://raw.githubusercontent.com/0zz4r/bashflix/master/install.sh))
    echo "Updated!"
    exit 0
    ;;

  "-p" | "--previously-watched")
    echo "Previously watched:"
    echo "$(cat $HOME/.bashflix_history)"
    exit 0
    ;;

  "-s" | "--select-torrent")
    query="$2"
    query="${query#\ }"
    query="${query%\ }"
    query="${query// /.}"
    magnet=$(pirate-get -C 'echo "%s"' "${query}" | tail -n 1)
    magnet="${magnet:2}"
    ;;

  *)
    echo "Searching the best torrent..."
    query="$1"
    query="${query#\ }"
    query="${query%\ }"
    query="${query// /.}"
    magnet=$(pirate-get -0 -C 'echo "%s"' "${query}" | tail -n 1)
    ;;
esac

echo "$query" | cat - $HOME/.bashflix_history > temp && mv temp $HOME/.bashflix_history
  
if [ -z $magnet ]; then
  echo "Could not find torrent for query ${query}." 
  echo "Please change the query."
  exit 1
else
  echo "Torrent found: ${magnet}"
fi

language=$2
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
    find /tmp/bashflix/${query} -maxdepth 1 -name "*${language}*.srt" | head -1 | xargs -I '{}' mv {} "/tmp/bashflix/${query}/${query}.${language}.srt"
    subtitle=$(find /tmp/bashflix/${query} -maxdepth 1 -name "${query}.${language}.srt" | head -1)
    if [ -n "$subtitle" ]; then
      echo "Found subtitle for language ${language}"
      break;
    fi
  done
fi

echo "Streaming ${torrent_name} with ${subtitle}..."
if [ -z "${subtitle}" ]; then
  peerflix ${magnet} --vlc -- --fullscreen
else
  peerflix ${magnet} --subtitles ${subtitle} --vlc -- --fullscreen 
fi
