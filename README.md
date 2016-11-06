# bashflix
Linux/Mac OS X bash script to watch movies and series with subtitles, instantaneously. Just give the name, quickly grab your popcorn and start watching :) 

![](http://i.imgur.com/FX4bt1B.gif)

**Demo (32s):** https://youtu.be/neA2PtCmY_U

# Usage
You can run it from everywhere. Just open terminal (ctrl+alt+t) and type:

**Examples:** 
```
bashflix.sh The.Walking.Dead.S07E02 pt
```
```
bashflix.sh Blood.Father fr
```
```
bashflix.sh John.Wick
```
**Format:** 
```
bashflix.sh Series.To.Watch.SXXEYY language
```
or
```
bashflix.sh Movie.To.Watch language
``` 

If you do not input language, default is no language. If you input a language, the alterative is **en** in case your language was not found.

# Installation and Configuration

## Linux (Ubuntu for example)
Open terminal (ctrl+alt+t) and type:

1. Make install-Linux.sh runnable:
  
  ```
  cd Downloads/bashflix-master
  ```
  ```
  chmod u+x install-Linux.sh
  ``` 
2. Run install script:
  
  ```
  ./install-Linux.sh YOUR_LINUX_PASSWORD
  ```
  *Your Linux password is required because some programs can only be installed with it (sudo)*
  
To change defalut language, change variable *lang2* in bashflix.sh 

# How it works?
It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) for torrent search, with [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles








