# bashflix 🍿
bashflix is a free video streaming with subtitles script that runs on MacOS and Linux 🎥

Here's a 15 seconds demo ▶️

![](https://media.giphy.com/media/KeHU2lgmJG48m4hzp8/giphy.gif)


## How to install (can take a few minutes):
If you are on MacOS, 
1. Press ```⌘+space```, type ```terminal``` and press ```RETURN``` to open terminal app;
2. Copy & paste onto the terminal the following command to install Homebrew and update Bash: 🍺
``` 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
brew install bash
```
3. Press ```RETURN``` and follow instructions presented on the terminal;

Run install script: 🖵
```
bash -c "$(curl -s https://raw.githubusercontent.com/0zz4r/bashflix/master/install.sh)"
```
## How to use:
Open terminal app and type `bashflix "QUERY" [SUBTITLES_LANGUAGE]`, then wait a few seconds for the magic to happen 🪄✨

   (e.g. ```bashflix "MOVIE / SERIE S01E01 1080p" en```)

## Not working? 🙁
* Run `bashflix update`;
* Add `select` before `"QUERY"`;
* Pause video and wait a bit;
* To sync subtitles, press `j` to speed it up or `h` to delay it;
* [Change DNS to 1.1.1.1](https://1.1.1.1/dns/);
* Please report the issue [here](https://github.com/0zz4r/bashflix/issues/new/choose) so we can fix it.

## Powered by
[**pirate-get**](https://github.com/vikstrous/pirate-get) for magnet link search, [**peerflix**](https://github.com/mafintosh/peerflix) for streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles download.

## Disclaimer
Downloading files via torrents might be illegal, depending on the content, so be aware of copyright infringements. Use a [VPN](https://www.mysteriumvpn.com/) for privacy.

## License
This project is licensed under the terms of the [MIT license](https://github.com/0zz4r/bashflix/blob/master/LICENSE.md).
