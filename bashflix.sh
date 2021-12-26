#!/usr/bin/env bash

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -h|--help)
      echo -n "
      ██████╗  █████╗ ███████╗██╗  ██╗███████╗██╗     ██╗██╗  ██╗
      ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║╚██╗██╔╝
      ██████╔╝███████║███████╗███████║█████╗  ██║     ██║ ╚███╔╝ 
      ██╔══██╗██╔══██║╚════██║██╔══██║██╔══╝  ██║     ██║ ██╔██╗ 
      ██████╔╝██║  ██║███████║██║  ██║██║     ███████╗██║██╔╝ ██╗
      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝╚═╝  ╚═╝

      "
      echo "Video streaming on MacOS and Linux, with subtitles."
      echo 
      echo "Quick start: bashflix \"movie 1080p\" en"
      echo "             bashflix \"QUERY\" [SUBTITLES_LANGUAGE]"
      echo 
      echo "Usage: 'bashflix [COMMAND] [OPTIONS]'"
      echo
      echo "Commands:"
      echo "  update                                  Update bashflix"
      echo "  previously                              Previously watched"
      echo "  select \"QUERY\" [SUBTITLES_LANGUAGE]   Select torrent from list"
      echo 
      echo "Options:"
      echo "  -h, --help            See this text"
      echo "  -p, --player PLAYER   Specify the player"
      echo 
      echo "Tips:"
      echo "  * If the first torrent doesn't work, add 'select' before \"QUERY\" and type the torrent number;"
      echo "  * Subtitles not synced? Press 'j' to speed it up or 'h' to delay it;"
      echo "  * What did I watch? Type 'bashflix previously' to see which episodes you previoulsy watched;"
      echo "  * Update bashflix from time to time by running 'bashflix update'."
      exit 0
      ;;
    u|update)
      $(sudo bash -c "$(curl -s https://raw.githubusercontent.com/0zz4r/bashflix/master/install.sh)")
      echo "Updated!"
      exit 0
      ;;
    p|previously)
      echo "Previously watched:"
      echo "$(head ~/bashflix_previously.txt)"
      exit 0
      ;;
    s|select)
      QUERY="$2"
      if [ -n "$2" ] && [[ "$2" != *"-"* ]]; then
        SUBTITLES_LANGUAGE="$3"
        shift
      fi
      shift # past argument
      shift # past value
      

      query="${QUERY#\ }"
      query="${query%\ }"
      query="${query// /.}"
      magnet=$(pirate-get -C 'echo "%s"' "${query}" | tail -n 1)
      magnet="${magnet:2}"
      ;;
    -p|--player)
      PLAYER="$2"
      shift
      shift
      ;;
    *)    # unknown option
      #POSITIONAL+=("$1") # save it in an array for later
      #shift # past argument

      QUERY="$1"
      if [ -n "$2" ] && [[ "$2" != *"-"* ]]; then
        SUBTITLES_LANGUAGE="$2"
        shift
      fi
      shift

      echo "Searching the best torrent..."
      query="${QUERY#\ }"
      query="${query%\ }"
      query="${query// /.}"
      magnet=$(pirate-get -0 -C 'echo "%s"' "${query}" | tail -n 1)

      if [ -z $magnet ]; then
        echo "Could not find torrent for query ${query}." 
        echo "Please change the query."
        exit 1
      else
        echo "Torrent found: ${magnet}"
      fi
      ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

echo "${query}" | cat - ~/bashflix_previously.txt > temp && mv temp ~/bashflix_previously.txt

language="${SUBTITLES_LANGUAGE}"
if [ -z "${PLAYER}" ]; then
  PLAYER="vlc"
fi

subtitle=""
if [ -n "${language}" ]; then
  echo "Searching the best subtitles..."
  torrent_name_param=$(awk -F "&" '{print $2}' <<< "$magnet")
  torrent_name_dirty=$(awk -F "=" '{print $2}' <<< "$torrent_name_param")
  torrent_name_raw=$(echo "${torrent_name_dirty}" | sed -e 's/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g')
  torrent_name_escaped=$(echo -e "${torrent_name_raw}")
  torrent_name=$(echo -e "${torrent_name_escaped}")
  mkdir -p "/tmp/bashflix/${query}"
  languages=("${language}")
  languages+=("en")
  for language in ${languages[@]}; do
    echo "Trying to find subtitles for ${torrent_name} in ${language}"
    subliminal --opensubtitles 0zz4r R4zz0___ download -l "${language}" -p opensubtitles -d "/tmp/bashflix/${query}" "${torrent_name}"
    find /tmp/bashflix/${query} -maxdepth 1 -name "*${language}*.srt" | head -1 | xargs -I '{}' mv {} "/tmp/bashflix/${query}/${query}.${language}.srt"
    subtitle=$(find /tmp/bashflix/${query} -maxdepth 1 -name "${query}.${language}.srt" | head -1)
    if [ -n "${subtitle}" ]; then
      echo "Found subtitle for language ${language}"
      break;
    fi
  done
fi


if [ -z "${subtitle}" ]; then
  echo "Streaming ${torrent_name}"
  peerflix "${magnet}" --"${PLAYER}" -- --fullscreen
else
  echo "Streaming ${torrent_name} with ${subtitle}..."
  peerflix "${magnet}" -t "${subtitle}" --"${PLAYER}" -- --fullscreen 
fi
