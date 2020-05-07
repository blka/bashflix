# bashflix
Watch movies and TV shows on Mac OS X and Linux, with subtitles, instantaneously. Just give the name, quickly grab your popcorn and have fun!

![](https://media.giphy.com/media/mACRrW4R25kuQLexXn/giphy.gif)

# Usage
Once installed, open terminal (```⌘+space```, then type ```terminal```, or ```ctrl+alt+t```) and type:

```
bashflix "Series To Watch sXXeYY" language
```
or
```
bashflix "Movie To Watch" language
```
**Example:**
```
bashflix "Mr Robot 1080p s02e02" pt
```

**Not working?** Install bashflix again.

**Usage history:**
```
bashflix -h
```


**Subtitles Tip:** 
If the subtitles are not synced, use ```z``` to speed it up or ```x``` to delay it.


# Installation
1. Open terminal (```⌘+space```, then type ```terminal```, or ```ctrl+alt+t```);
2. Copy & Paste the following command into the terminal and then press ENTER:
```
git clone https://github.com/astavares/bashflix.git && cd bashflix && ./install.sh
```
3. Input your system password and press ENTER (sudo required);
4. Wait a few minutes.

# How it works?

It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) and [**rarbgapi**](https://pypi.org/project/RarbgAPI/) for torrent search, [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles
