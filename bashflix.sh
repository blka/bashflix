#!/usr/bin/env bash

#
# Bashflix Script (https://github.com/astavares/bashflix)
#

request_query_raw=$1

if [ -z "${request_query_raw}" ]; then
  echo "Search query is mandatory!"
  echo ""
  echo "usage: $0 <movie name> | <serie name>.s<seasson>e<episode>"
  echo ""
  echo "notes:"
  echo "      <movie name> and <serie name> should avoid containing spaces, use dots (.) instead"
  echo "      <seasson> and <episode> should be zero padded, always have two digits"
  exit 1
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

tmp_dir="$(mktemp -d -t ${request_query})"

echo "Using ${tmp_dir} as temporary directory"

function cleanup {
  echo "Removing temporary directory ${tmp_dir}"
  rm  -r ${tmp_dir}
  echo "See you soon!"
}
trap cleanup EXIT

retrieve-magnet() {
  local search_term=$1

  echo "Downloading the best magnet for ${search_term}"

  local magnet_string=$(pirate-get -s SeedersDsc -0 -C 'echo "%s"' ${search_term} | tail -n 1)

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

get-subtitle-file() {
  local language=$1
  local torrent_name=$2

  subliminal download -l $language -d ${tmp_dir} ${torrent_name}
}

get-subtitle() {
  local torrent_name="$1"
  local subtitle_filename=""

  local languages=("en" "pt")
  for language in ${languages[@]}; do
    get-subtitle-file ${language} ${torrent_name}

    subtitle_filename=$(find ${tmp_dir} -maxdepth 1 -name "*.srt" | head -1)
    if [ -n "$subtitle_filename" ]; then
      echo "Found subtitle for language ${language}"
      FUN_RET="${subtitle_filename}"
      return 0;
    fi
  done

  FUN_RET=""
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

# Get subtitles
get-subtitle "${torrent_name}"
subtitle="${FUN_RET}"

# Run with peerflix
if [ -n "${subtitle}" ]; then
  echo "Playing ${torrent_name} with subtitles ${subtitle}"
  # peerflix "${magnet_string}" -k -t "${subtitle}"
  peerflix "${magnet_string}" -v -- --sub-file="${subtitle}"
else
  echo "Playing ${magnet_string}"
  # peerflix "${magnet_string}" -k
  peerflix "${magnet_string}" -v
fi
