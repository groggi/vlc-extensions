# vlc-extensions

This repository contains some simple [VLC Lua Playlist Scripts](https://wiki.videolan.org/Documentation:Building_Lua_Playlist_Scripts/). You find there also basic instructions how to deploy the Lua scripts :-).

## lua/sd/absradio.lua
Parses the Icecast server of www.absoluteradio.co.uk to extract all radio streams.

## lua/sd/tedfeed.lua
Parses http://feeds.feedburner.com/tedtalks_video to get the latest TED talks. With this "Service Discovery" you're able to watch these talks right inside VLC. However, the quality isn't that good as the feed does not provide URLs to the high-quality versions.