#!/usr/bin/env bash

#
# Bashflix Script (https://github.com/astavares/bashflix)
#

request_query_raw=$1
language=${2}
player=${3:-mpv}
clean=${4}

default_language="en"

if [ -z "${request_query_raw}" ]; then
  echo "Search query is mandatory!"
  echo ""
  echo "usage: $0 <search> [<language>] [<player>] [<clean>]"
  echo ""
  echo "notes:"
  echo "      <search> can be a <movie name> or <serie name>"
  echo "      <movie name> and <serie name> should avoid containing spaces, use dots (.) instead"
  echo "      <seasson> and <episode> should be zero padded, always have two digits"
  echo "      <language> defaults to en"
  echo "      <player> either mpv or vlc"
  echo "      <clean> remove torrent files and subtitles in the end"
  exit 1
else
  if [ "$1" == "-h" ]; then
    echo "$(cat $HOME/.bashflix_history)"
    exit 1
  else
    #echo "$(cat $HOME/.bashflix_history)$1" > $HOME/.bashflix_history

    echo -e "$request_query_raw" >> $HOME/.bashflix_history
  fi
fi

# HACK
# Global var to capture function return values
# Needed to do logs and return a value in the same function
FUN_RET=""

clean-str() {
  local raw_str="$1"
  raw_str="${raw_str#\ }"
  raw_str="${raw_str%\ }"
  raw_str="${raw_str// /.}"
  FUN_RET="${raw_str}"
}

clean-str "${request_query_raw}"
request_query="${FUN_RET}"

echo "Welcome to bashflix"

retrieve-magnet() {
  local search_term=$1

  echo "Downloading the best magnet for ${search_term}"

  local magnet_string=$(pirate-get -s SeedersDsc -0 -C 'echo "%s"' "${search_term}" | tail -n 1)

  if [ "${magnet_string}" = "No results" ]
  then
    echo "Pirate Bay. DOWN ;,( Trying ragrbg.org:"
    magnet_string=$(rarbgapi --search-string "${search_term}" | tail -n 1 | sed -n 's/^.*magnet:?/magnet:?/p')
  fi

  FUN_RET="${magnet_string}"
}

retrieve-name-from-magnet() {
  local magnet_string=$1

  echo "Parsing torrent name from magnet content"

  local torrent_name_param=$(awk -F "&" '{print $2}' <<< "$magnet_string")
  local torrent_name_dirty=$(awk -F "=" '{print $2}' <<< "$torrent_name_param")
  local torrent_name_raw=$(echo "$torrent_name_dirty" | sed -e 's/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g')
  local torrent_name_escaped=$(echo -e "$torrent_name_raw")
  # Not sure why I need to do this twice ?!?!?
  local torrent_name=$(echo -e "$torrent_name_escaped")

  FUN_RET="${torrent_name}"
}

retrieve-magnet-hash() {
  local magnet_string=$1

  echo "Parsing torrent hash from magnet content"

  local torrent_hash=$(echo "$magnet_string" | awk -F ":" '{print $4}' | awk -F "&" '{print $1}')

  FUN_RET="${torrent_hash}"
}

get-subtitle-file() {
  local language="$1"
  local torrent_name="$2"
  local tmp_dir="$3"

  subliminal download -l "$language" -d "${tmp_dir}" "${torrent_name}"
}

get-subtitle() {
  local torrent_name="$1"
  local tmp_dir="$2"

  local subtitle_filename=""
  local languages=()

  if [ "${language}" != "${default_language}" ]; then
    languages+=("${language}")
  fi
  languages+=("${default_language}")

  for language in ${languages[@]}; do
    get-subtitle-file "${language}" "${torrent_name}" "${tmp_dir}"

    subtitle_filename=$(find ${tmp_dir} -maxdepth 1 -name "*${language}*.srt" | head -1)
    if [ -n "$subtitle_filename" ]; then
      echo "Found subtitle for language ${language}"
      break;
    fi
  done

  FUN_RET="${subtitle_filename}"
}

# Get magnet
retrieve-magnet "${request_query}"
magnet_string="${FUN_RET}"

if [ "${magnet_string}" == "No results" ]; then
  echo "Cannot find content for the query ${request_query}"
  exit 1
fi

# Get torrent name from magnet
retrieve-name-from-magnet "${magnet_string}"
torrent_name="${FUN_RET}"

# Get torrent hash from magnet
retrieve-magnet-hash "${magnet_string}"
torrent_hash="${FUN_RET}"

tmp_dir="/tmp/torrent-stream/${torrent_hash}"

mkdir -p "${tmp_dir}"

echo "Using ${tmp_dir} as temporary directory"

if [ -n "${clean}" ]; then
  function cleanup {
    echo "Removing temporary directory ${tmp_dir}"
    rm  -r ${tmp_dir}
    echo "See you soon!"
  }
  trap cleanup EXIT
fi

# Get subtitles
if [ -n "${language}" ]; then
  get-subtitle "${torrent_name}" "${tmp_dir}"
  subtitle="${FUN_RET}"
fi

case $player in
vlc)
  player_flag="-v"
  subtitle_args=(-- --sub-file="${subtitle}")
  ;;
*)
  player_flag="-k"
  subtitle_args=(-t "${subtitle}")
  ;;
esac

# Run with peerflix
if [ -n "${subtitle}" ]; then
  echo "Playing ${torrent_name} with subtitles ${subtitle}"
  peerflix "${magnet_string}" "${player_flag}" ${subtitle_args[@]}
else
  echo "Playing ${torrent_name}"
  peerflix "${magnet_string}" "${player_flag}"
fi
