# bashflix 🍿
Video streaming on MacOS and Linux, with subtitles 🎥

![](https://media.giphy.com/media/mACRrW4R25kuQLexXn/giphy.gif)

## How to use
1. Open terminal app 💻
2. Type `bashflix "QUERY" [SUBTITLES_LANGUAGE]` ⌨️
3. Wait a few seconds for the magic to happen ✨ 

##### Examples:
```
bashflix "movie 1080p"
```
```
bashflix "serie s01e01" en
```

## How to install
1. Open terminal app 💻
2. (Only MacOS) Install Homebrew and update Bash by running: 🍺
``` 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && brew install bash
```
3. Run install script: 🏃‍♀️ 
```
curl https://raw.githubusercontent.com/0zz4r/bashflix/master/install.sh | sudo bash -
```
4. (Optional) [Change DNS to 1.1.1.1](https://1.1.1.1/dns/) to prevent torrent search failures 😵

## Tips
* If the first torrent doesn't work, add `-s` before `"QUERY"` and then select a different torrent;
* Subtitles not synced? Press `j` to speed it up or `h` to delay it;
* What did I watch? Type `bashflix -p` to see which episodes you previoulsy watched;
* Update bashflix from time to time by running `bashflix -u`.

## Powered by
[**pirate-get**](https://github.com/vikstrous/pirate-get) for torrent search, [**peerflix**](https://github.com/mafintosh/peerflix) and [**vlc**](https://github.com/videolan/vlc) for torrent streaming and playing,  and [**subliminal**](https://github.com/Diaoul/subliminal) to download subtitles.

## Disclaimer
bashflix is under development. If you want the newer features or bugs fixed, just updated it from time to time. Some torrents (and subtitles) will not be found or will have few peers, which will make the video stop multiple times.
Downloading files via torrents might be illegal, depending on the content, so be aware of copyright infringements. Use a VPN for privacy.

## License
This project is licensed under the terms of the [MIT license](https://github.com/0zz4r/bashflix/blob/master/LICENSE.md).
