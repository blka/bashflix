# bashflix 🍿
Video streaming on MacOS and Linux, with subtitles 🎥

![](https://media.giphy.com/media/KeHU2lgmJG48m4hzp8/giphy.gif)


# Quick start 💨
1. Open terminal app 💻
2. [MacOS] Install Homebrew and Bash (be patient): 🍺
``` 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
brew install bash
```
3. Install bashflix (be patient): 🖵
```
bash -c "$(curl -s https://raw.githubusercontent.com/0zz4r/bashflix/master/install.sh)"
```
4. Type `bashflix "QUERY" [SUBTITLES_LANGUAGE]` ⌨️

    (e.g. ```bashflix "serie s01e01 1080p" en```)

5. Wait a few seconds for the magic to happen 🪄✨

# Not working? 🙁
* Run `bashflix update`;
* Add `select` before `"QUERY"`;
* Pause video and wait a bit;
* To sync subtitles, press `j` to speed it up or `h` to delay it;
* [Change DNS to 1.1.1.1](https://1.1.1.1/dns/);
* Please report the issue [here](https://github.com/0zz4r/bashflix/issues/new/choose) so we can fix it.

# Powered by
[**pirate-get**](https://github.com/vikstrous/pirate-get) for magnet link search, [**peerflix**](https://github.com/mafintosh/peerflix) for streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles download.

# Disclaimer
Downloading files via torrents might be illegal, depending on the content, so be aware of copyright infringements. Use a [VPN](https://www.mysteriumvpn.com/) for privacy.

# License
This project is licensed under the terms of the [MIT license](https://github.com/0zz4r/bashflix/blob/master/LICENSE.md).
