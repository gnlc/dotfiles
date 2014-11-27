#!/bin/sh

# Docker container run commands for ArchX

##
# Plex
##
docker run -d --name=plex --net=host -v /etc/localtime:/etc/localtime:ro -v /appdata/plex:/config -v /mnt/storage:/data -e PGID=1001 -e PUID=1001 -e PLEXPASS=1 -p 32400:32400 lonix/plex:1.3

##
# SABnzbd+
##
#docker run -d -p 27020:8080 --name=sabnzbd -v /appdata/sabnzbd:/config -v /mnt/storage:/mnt/storage  -v /etc/localtime:/etc/localtime:ro binhex/arch-sabnzbd

docker run -d --name=sabnzbd -v /etc/localtime:/etc/localtime:ro -v /appdata/sabnzbd:/config -v /mnt/storage:/mnt/storage -e PGID=1001 -e PUID=1001 -p 27020:8080 lonix/sabnzbd

##
# NZBDrone
##
docker run -d --name=nzbdrone -v /appdata/nzbdrone:/config -v /mnt/storage/downloads:/downloads -v /mnt/storage/Media/TV:/tv -v /etc/localtime:/etc/localtime:ro -e PGID=1001 -e PUID=1001 -p 27021:8989 lonix/nzbdrone:2.0
docker run -d --name=nzbdrone_family -v /appdata/nzbdrone_family:/config -v /mnt/storage/downloads:/downloads -v /mnt/storage/Media/TV_Family:/tv -v /etc/localtime:/etc/localtime:ro -e PGID=1001 -e PUID=1001 -p 28021:8989 lonix/nzbdrone:2.0

##
# CouchPotato
##
docker run -d --name=couchpotato -v /etc/localtime:/etc/localtime:ro -v /appdata/couchpotato:/config -v /mnt/storage/downloads/complete/movies:/downloads -v /mnt/storage/Media/Movies:/movies -e PGID=1001 -e PUID=1001 -p 27022:5050 lonix/couchpotato:2.0

##
# BTSync
##
docker run -d --name=btsync -p 8888:8888 -p 55555:55555 -v /appdata/btsync:/btsync/ -v /mnt/storage/:/storage lonix/btsync:1.3.1

##
# Transmission
##
docker run -d --net="host" --name=transmission -e USERNAME="alexktz" -e PASSWORD="editme" -v /appdata/transmission:/config -v /mnt/storage/downloads/torrents:/downloads -v /etc/localtime:/etc/localtime:ro gfjardim/transmission

##
# Smokeping
## needs updating for ArchX paths
#docker run --name smokeping -p 8000:80 -v /root/smokeping/smokeping:/etc/smokeping:ro\ -v /etc/localtime:/etc/localtime:ro -d dperson/smokeping
#docker run --name smokeping -p 8000:80 -v /mnt/storage/appdata/smokeping:/etc/smokeping:ro -v /etc/localtime:/etc/localtime:ro -d dperson/smokeping
