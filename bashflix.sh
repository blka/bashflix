#!/usr/bin/env bash

#set -ex

help () {
    echo -n "
██████╗  █████╗ ███████╗██╗  ██╗███████╗██╗     ██╗██╗  ██╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║╚██╗██╔╝
██████╔╝███████║███████╗███████║█████╗  ██║     ██║ ╚███╔╝ 
██╔══██╗██╔══██║╚════██║██╔══██║██╔══╝  ██║     ██║ ██╔██╗ 
██████╔╝██║  ██║███████║██║  ██║██║     ███████╗██║██╔╝ ██╗
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝╚═╝  ╚═╝
"
    echo "Bash script that combines several open source tools to stream video."
    echo 
    echo "Usage: bashflix [COMMAND] [OPTIONS]"
    echo
    echo "Commands:"
    echo "  update                                     Update bashflix"
    echo "  previously                                 Previously watched"
    echo "  select \"SEARCH TERM\" [SUBTITLES_LANGUAGE]  Select torrent from list"
    echo "  help                                       See this text"
    echo 
    echo "Options:"
    echo "  -p, --player PLAYER                        Specify the player (default: vlc)"
    echo
    echo "Tips:"
    echo "  * Run 'bashflix update';"
    echo "  * Change DNS resolver to 1.1.1.1 - https://1.1.1.1/dns/;"
    echo "  * Add 'select' before \"SEARCH TERM\";"
    echo "  * Pause video and wait a bit;"
    echo "  * To sync subtitles, press 'j' to speed it up or 'h' to delay it;"
    echo "  * Please report issues here: https://github.com/andretavare5/bashflix/issues/new/choose."
    echo "  * Use a VPN for privacy (protonvpn.com)."
}

SELECT=false
PLAYER="vlc"
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    h|help)
      help
      exit 0
      ;;
    u|update)
      bash -c "$(curl -s https://raw.githubusercontent.com/andretavare5/bashflix/master/install.sh)"
      echo "Updated!"
      exit 0
      ;;
    p|previously)
      echo "Previously watched:"
      echo "$(head ~/bashflix_previously.txt)"
      exit 0
      ;;
    s|select)
      SELECT=true
      QUERY="$2"
      if [ -n "$2" ] && [[ "$2" != *"-"* ]]; then
        SUBTITLES_LANGUAGE="$3"
        shift
      fi
      shift # past argument
      shift # past value      
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
      ;;
  esac
done

if [ -z "$QUERY" ]; then
  help
  exit 0
fi

set -- "${POSITIONAL[@]}" # restore positional parameters

echo "${query}" | cat - ~/bashflix_previously.txt > temp && mv temp ~/bashflix_previously.txt
query="${QUERY#\ }"
query="${query%\ }"
query="${query// /.}"

if [ "$SELECT" = true ]; then
  echo "q" | pirate-get --total-results 5 -C 'echo "%s"' "${query}"
  echo
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "|                                                               |"
  echo "| PLEASE LOOK AT THE LIST ABOVE ^^^ AND INPUT THE *LINK* NUMBER |"
  echo "|                                                               |"
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo
  out=$(pirate-get --total-results 5 -C 'echo "%s"' "${query}")
  magnet="${out:2}"
else
  magnet=$(pirate-get --total-results 1 -0 -C 'echo "%s"' "${query}")
fi

if [ -z $magnet ]; then
  exit 1
fi

if [ -n "${SUBTITLES_LANGUAGE}" ]; then
  torrent_name_param=$(awk -F "&" '{print $2}' <<< "$magnet")
  torrent_name_dirty=$(awk -F "=" '{print $2}' <<< "$torrent_name_param")
  torrent_name_raw=$(echo "${torrent_name_dirty}" | sed -e 's/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g')
  torrent_name_escaped=$(echo -e "${torrent_name_raw}")
  torrent_name=$(echo -e "${torrent_name_escaped}")
  mkdir -p "/tmp/bashflix/${query}"
  languages=("${SUBTITLES_LANGUAGE}" "en")
  echo "Searching subtitles for ${torrent_name}"
  for language in ${languages[@]}; do
    subliminal --opensubtitles bashflix Open_5ubtitles download -l "${language}" -p opensubtitles -d "/tmp/bashflix/${query}" "${torrent_name}"
    find /tmp/bashflix/${query} -maxdepth 1 -name "*${language}*.srt" | head -1 | xargs -I '{}' mv {} "/tmp/bashflix/${query}/${query}.${language}.srt"
    subtitle=$(find /tmp/bashflix/${query} -maxdepth 1 -name "${query}.${language}.srt" | head -1)
    if [ -n "${subtitle}" ]; then
      echo "in ${language}"
      break;
    fi
  done
fi

if [ -z "${subtitle}" ]; then
  peerflix "${magnet}" -n -r --"${PLAYER}" -- --fullscreen
else
  peerflix "${magnet}" -n -r -t "${subtitle}" --"${PLAYER}" -- --fullscreen 
fi
