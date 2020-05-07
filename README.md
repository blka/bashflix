# bashflix
Watch movies and TV shows on Mac OS X and Linux, with subtitles, instantaneously. Just give the name, quickly grab your popcorn and have fun!

![](https://media.giphy.com/media/mACRrW4R25kuQLexXn/giphy.gif)

# How to use?
Once installed:
1. Open terminal (```⌘+space```, then type ```terminal```, or ```ctrl+alt+t```)
2. Type (format and example):
```
bashflix "movie / tv series sXXeYY" language
```
```
bashflix "westworld s03e01 1080p" pt
```
3. Wait a few seconds for the player to open.

Tips:
1. If subtitles are not synced, use ```z``` to speed it up or ```x``` to delay it.
2. Double click to full screen.
3. What did I watched?
```
bashflix -h
```

# How to install?
1. Open terminal (```⌘+space```, then type ```terminal```, or ```ctrl+alt+t```);
2. Copy & Paste the following command into the terminal and then press ENTER:
```
git clone https://github.com/astavares/bashflix.git && cd bashflix && ./install.sh
```
3. Input your system password and press ENTER (sudo required);
4. Wait a few minutes until it finishes. If it fails, repeat.

# Not working?
Try install bashflix again, usually it works :)

# How it works?

It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) and [**rarbgapi**](https://pypi.org/project/RarbgAPI/) for torrent search, [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles
