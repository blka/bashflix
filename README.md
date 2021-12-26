# bashflix 🍿
Video streaming on MacOS and Linux, with subtitles 🎥

![](https://media.giphy.com/media/KeHU2lgmJG48m4hzp8/giphy.gif)


# How to use
1. Open terminal app 💻
2. Type `bashflix "QUERY" [SUBTITLES_LANGUAGE]` 
e.g. ```bashflix "serie s01e01 1080p" en```
4. Wait a few seconds for the magic to happen 🪄✨

# How to install
1. Open terminal app 💻
2. (Only on MacOS) Install Homebrew and update Bash by running: 🍺
``` 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
brew install bash
```
3. Run install script: 🏃‍♀️ 
```
sudo bash -c "$(curl -s https://raw.githubusercontent.com/0zz4r/bashflix/master/install.sh)"
```

# Not working?
* Run `bashflix update`;
* [Change DNS to 1.1.1.1](https://1.1.1.1/dns/);
* Add `select` before `"QUERY"`;
* Pause video and wait a bit.

# Powered by
[**pirate-get**](https://github.com/vikstrous/pirate-get) for torrent search, [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming,  and [**subliminal**](https://github.com/Diaoul/subliminal) to download subtitles.

# Disclaimer
bashflix is under development. Feel free to report bugs or ask for new features. 
Downloading files via torrents might be illegal, depending on the content, so be aware of copyright infringements. Use a VPN for privacy.

# License
This project is licensed under the terms of the [MIT license](https://github.com/0zz4r/bashflix/blob/master/LICENSE.md).
