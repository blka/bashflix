# bashflix
Linux script to watch movies and series with subtitles, instantaneously. Just give the name, quickly grab your popcorn and start watching :) 

# Usage
**Example:** 
```
./bashflix.sh The.Walking.Dead.S07E02
```
or
```
./bashflix.sh Captain.America.Civil.War
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
1. Install [**pirate-get**](https://github.com/vikstrous/pirate-get), [**peerflix**](https://github.com/mafintosh/peerflix), [**subliminal**](https://github.com/Diaoul/subliminal), and [**smplayer**](http://smplayer.sourceforge.net/)
2. To run bashflix.sh:
  ```
  cd bashflix-master
  ```
  ```
  chmod u+x bashflix.sh
  ``` 
3. To change subtitles language, open bashflix.sh and change *lang1* and *lang2*. Change both if you want an alternative, in case your first language is not found.

# How it works?
It combines [**pirate-get**](https://github.com/vikstrous/pirate-get) for torrent search, with [**peerflix**](https://github.com/mafintosh/peerflix) for torrent streaming, and [**subliminal**](https://github.com/Diaoul/subliminal) for subtiltes








