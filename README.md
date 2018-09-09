# bashflix
Watch movies and TV shows on Mac OS X / Ubuntu, with subtitles, instantaneously. Just give the name, quickly grab your popcorn and have fun!

![](http://i.imgur.com/FX4bt1B.gif)

# Usage
Once installed, you can run it from everywhere. Just open terminal (```⌘+space, then type terminal``` or ```ctrl+alt+t```) and type:

**Examples:**
```
bashflix "the walking dead s07e02" pt
```
```
bashflix "Blood Father" fr
```
```
bashflix "John Wick 1080p"
```
**Format:**
```
bashflix "Series To Watch sXXeYY" language
```
or
```
bashflix "Movie To Watch" language
```
**Usage history:**
```
bashflix -h
```
**Subtitles Tip:** 
If the subtitles are not synced, use ```z``` to speed it up or ```x``` to delay it

If you do not input language, default is no language.
If you input a language, the alterative is **en** in case your language was not found.

# Installation and Configuration

## Linux (Ubuntu for example) and Mac OS X

1. After you download the zip and extract its content to the folder ```Downloads```, open terminal (```⌘+space, then type terminal``` or ```ctrl+alt+t```) and type:

  ```
  cd Downloads/bashflix-master
  ```

2. Then, run install script:

  ```
  ./install.sh
  ```

Advanced config: To change default alternative language, change variable *default_language* in file bashflix.sh.

# How it works?

It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) for torrent search, with [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles
