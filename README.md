# bashflix

Linux bash script to watch movies and series with subtitles, instantaneously.
Just give the name, quickly grab your popcorn and start watching :) 

![](http://i.imgur.com/FX4bt1B.gif)

# Usage
You can run it from everywhere. Just open terminal (ctrl+alt+t) and type:

**Examples:** 
```
bashflix The.Walking.Dead.S07E02 pt
```
```
bashflix Blood.Father fr
```
```
bashflix John.Wick
```
**Format:** 
```
bashflix Series.To.Watch.SXXEYY language
```
or
```
bashflix Movie.To.Watch language
``` 

If you do not input language, default is no language.
If you input a language, the alterative is **en** in case your language was not found.

# Installation and Configuration

## Linux (Ubuntu for example)

1. Open terminal (ctrl+alt+t) and type: 
  
  ``` 
  cd Downloads/bashflix-master
  ``` 

2. Run install script:
  
  ```
  ./install.sh
  ```
  
To change default language, change variable *default_language* in file bashflix.sh.

# How it works?

It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) for torrent search, with [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles
