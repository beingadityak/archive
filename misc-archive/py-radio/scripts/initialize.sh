#!/bin/sh

sudo rm -rf /var/lib/mpd/playlists/my_playlist.*

sudo cp /home/pi/scripts/my_playlist.m3u /var/lib/mpd/playlists
mpc clear
mpc load my_playlist
