#!/bin/sh

# Docker container run commands for ArchX

##
# Plex
##
docker run -d --name=plex --net=host -v /etc/localtime:/etc/localtime:ro -v /mnt/storage/appdata/plex:/config -v /mnt/storage:/data -e PGID=1001 -e PUID=1001 -e PLEXPASS=1 -p 32400:32400 lonix/plex:1.3

##
# NZBDrone
##
docker run -d --name=nzbdrone -v /mnt/storage/appdata/nzbdrone:/config -v /mnt/storage/downloads:/downloads -v /mnt/storage/Media/TV:/tv -v /etc/localtime:/etc/localtime:ro -p 27021:8989 lonix/nzbdrone:1.1

##
# SABnzbd+
##
docker run -d -p 27020:8080 --name=sabnzbd -v /mnt/storage/appdata/sabnzbd:/config -v /mnt/storage:/mnt/storage  -v /etc/localtime:/etc/localtime:ro binhex/arch-sabnzbd

##
# CouchPotato
##
docker run -d --name=couchpotato -v /etc/localtime:/etc/localtime:ro -v /mnt/storage/appdata/couchpotato:/config -v /mnt/storage/downloads/complete/movies:/downloads -v /mnt/storage/Media/Movies:/movies -p 27022:5050 lonix/couchpotato:1.1

##
# BTSync
##
docker run -d --name=btsync -p 8888:8888 -p 55555:55555 -v /mnt/storage/appdata/btsync:/btsync/ -v /mnt/storage/:/storage lonix/btsync:1.2

##
# Transmission
##
docker run -d --net="host" --name=transmission -e USERNAME="alexktz" -e PASSWORD="editme" -v /mnt/storage/appdata/transmission:/config -v /mnt/storage/downloads/torrents:/downloads -v /etc/localtime:/etc/localtime:ro gfjardim/transmission

##
# Smokeping
## needs updating for ArchX paths
docker run --name smokeping -p 8000:80 -v /root/smokeping/smokeping:/etc/smokeping:ro\ -d dperson/smokeping
