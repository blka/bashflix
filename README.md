# bashflix
Watch movies and TV shows on Mac OS X and Linux, with subtitles, instantaneously. Just give the name, quickly grab your popcorn and have fun!

![](https://media.giphy.com/media/mACRrW4R25kuQLexXn/giphy.gif)

# How to use?
Once installed:
1. Open terminal (```⌘+space```, then type ```terminal```, or ```ctrl+alt+t```)
2. Type the following command (format and example) in the terminal and press ENTER:
```
bashflix "movie / tv series sXXeYY" language
```
```
bashflix "westworld s03e01 1080p" pt
```
3. Wait a few seconds for the player to open.

# Tips
1. Stuck? ```ctrl+c``` and try again, usually it works :)
2. Fullscreen? Double click on the image.
3. Subtitles not synced? Use ```z``` to speed it up or ```x``` to delay it.
4. What did I watch? ```bashflix -h```

# How to install?
1. Open terminal (```⌘+space```, then type ```terminal```, or ```ctrl+alt+t```);
2. Copy & Paste the following command into the terminal and press ENTER:
```
cd ~ && rm -rf bashflix && git clone https://github.com/astavares/bashflix.git && cd bashflix && ./install.sh
```
3. Input your system password and press ENTER (sudo required);
4. Wait a few minutes until it finishes. If it fails, repeat.

# Not working?
Try install bashflix again, usually it works :)
CONTRIBUTIONS ARE WELCOME! (PR)

# How it works?
It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) and [**rarbgapi**](https://pypi.org/project/RarbgAPI/) for torrent search, [**webtorrent**](https://github.com/webtorrent/webtorrent) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles


# License
This project is licensed under the terms of the [MIT license](https://github.com/astavares/bashflix/blob/master/LICENSE.md).
