# bashflix
Linux/Mac OS X bash script to watch movies and series with subtitles, instantaneously. Just give the name, quickly grab your popcorn and start watching :) 

![](http://i.imgur.com/FX4bt1B.gif)

**Demo (32s):** https://youtu.be/neA2PtCmY_U

# Usage
**Example:** 
```
./bashflix.sh The.Walking.Dead.S07E02
```
or
```
./bashflix.sh Blood.Father
```
**Format:** 
```
./bashflix.sh Series.To.Watch.SXXEYY
```
or
```
./bashflix.sh Movie.To.Watch
``` 

# Installation and Configuration

## Linux (Ubuntu for example)

1. Make install-Linux.sh runnable:
  
  ```
  cd bashflix-master
  ```
  ```
  chmod u+x install-Linux.sh
  ``` 
2. Run install script:
  
  ```
  ./install-Linux.sh YOUR_UBUNTU_PASSWORD
  ```
  *Your ubuntu password is required because some programs can only be installed with it (sudo)*
  
Default languages are **pt** and the alternative is **en**. To change subtitles language, open *bashflix.sh* and change *lang1* and *lang2*. The alternative is for the case when your primary language is not found.

# How it works?
It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) for torrent search, with [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles








