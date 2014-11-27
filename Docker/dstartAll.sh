#!/bin/bash

docker start plex
sleep 5
docker start sabnzbd
sleep 1
docker start nzbdrone
sleep 10
docker start nzbdrone_family
sleep 10
docker start couchpotato
sleep 5
docker start btsync
sleep 1
docker start transmission
