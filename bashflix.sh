#!/usr/bin/env bash
if [ "$1" == "-h" ]; then
  echo "$(cat $HOME/.bashflix_history)"
  exit 0
else
  echo -e "$request_query_raw" >> $HOME/.bashflix_history
fi

echo "Searching the best torrent..."
query="$1"
query="${query#\ }"
query="${query%\ }"
query="${query// /.}"
magnet=""
if [[ ${magnet} != *"magnet"* ]]; then
  magnet=$(pirate-get -s SeedersDsc -0 -C 'echo "%s"' "${query}" | tail -n 1)
  echo "Torrent found on The Pirate Bay: ${magnet}"
fi
if [[ ${magnet} != *"magnet"* ]]; then
  magnet=$(we-get --search "${query}" --target yts -L | head -n 1)
  echo "Torrent found on YTS: ${magnet}"
fi
if [[ ${magnet} != *"magnet"* ]]; then
  magnet=$(we-get --search "${query}" --target 1337x -L | head -n 1)
  echo "Torrent found on 1337x: ${magnet}"
fi
if [[ ${magnet} != *"magnet"* ]]; then
  magnet=$(rarbgapi --search-string "${query}" | tail -n 1 | sed -n 's/^.*magnet:?/magnet:?/p')
  echo "Torrent found on RARBG: ${magnet}"
fi
#if [[ ${magnet} != *"magnet"* ]]; then
#  magnet=$(we-get --search "${query}" --target eztv -L | head -n 1)
#  echo "Torrent found on EZTV: ${magnet}"
#fi
if [[ ${magnet} != *"magnet"* ]]; then
  echo "Could not find torrent for the query ${query}. Change the query."
  exit 1
fi

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
      #mv "/tmp/bashflix/${query}/*.srt" "/tmp/bashflix/${query}/${query}.${language}.srt"
      subtitle=$(find /tmp/bashflix/${query} -maxdepth 1 -name "*${language}*.srt" | head -1)
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

rm -rf /tmp/bashflix/${query}/*
