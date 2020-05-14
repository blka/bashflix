# bashflix
Watch movies and TV shows on Mac OS X and Linux, with subtitles, instantaneously. Just give the name, quickly grab your popcorn and have fun!

![](https://media.giphy.com/media/mACRrW4R25kuQLexXn/giphy.gif)

## How to use?
Once installed:
1. Open terminal (```⌘+space```, then type ```terminal```, or ```ctrl+alt+t```)
2. Type ```bashflix "movie / tv series sXXeYY" language``` in the terminal and press ENTER:
3. Wait a few seconds for the player to open.

Examples:
```
bashflix "jumanji next level"
```
```
bashflix "westworld s03e01 720p" pt
```

Tips:
* Stuck? ```ctrl+c``` and change the search query;
* Subtitles not synced? Use ```h``` to speed it up or ```g``` to delay it.
* Stopping? ```space``` to PAUSE, wait a few minutes and ```space``` to PLAY.
* What did I watch? ```bashflix -h```

## How to install?
1. Open terminal (```⌘+space```, then type ```terminal```, or ```ctrl+alt+t```);
2. Copy & Paste the following command into the terminal and press ENTER:
```
bash <(curl https://raw.githubusercontent.com/astavares/bashflix/master/install.sh)
```
3. Input your system password and press ENTER (sudo required);
4. Wait a few minutes until it finishes.

## Not working?
* [Change DNS to 1.1.1.1](https://1.1.1.1/dns/) (Cloudflare);
* Install bashflix again using the **NEW** installer:
```
bash <(curl https://raw.githubusercontent.com/astavares/bashflix/dev/install.sh)
```


## How it works?
It uses [**pirate-get**](https://github.com/vikstrous/pirate-get) and [**we-get**](https://github.com/rachmadaniHaryono/we-get) for torrent search, [**peerflix**](https://github.com/mafintosh/peerflix) and [**vlc**](https://github.com/videolan/vlc) for torrent streaming and playing,  and [**subliminal**](https://github.com/Diaoul/subliminal) for subtitles.

## Disclaimer
bashflix is under development. Best efford approch is used. Most of the times bashflix will work. Random errors will occur. Unavailability issues will occur. Some torrents and subtitles will not be found. Content downloading via torrents might be illegal. Be aware of copyright infringements. Use a VPN for privacy.

## License
This project is licensed under the terms of the [MIT license](https://github.com/astavares/bashflix/blob/master/LICENSE.md).
