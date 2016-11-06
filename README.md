# bashflix

Linux/Mac OS bash script to watch movies and series with subtitles, instantaneously.
Just give the name, quickly grab your popcorn and start watching :) 

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

If you do not input language, default is no language.
If you input a language, the alterative is **en** in case your language was not found.

# Installation and Configuration

## Linux (Ubuntu for example) and Mac OS
Open terminal (ctrl+alt+t) and type:

1. Make install.sh executable:
    
    ``` 
    cd Downloads/bashflix-master
    ``` 
    ``` 
    chmod u+x install.sh
    ``` 

1. Run install script:
  
  ```
  ./install.sh
  ```
  
To change default language, change variable *lang2* in file bashflix.sh.

# How it works?

It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) for torrent search, with [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles
