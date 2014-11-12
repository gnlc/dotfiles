#!/bin/bash
# 
# Creates a bunch of aliases to simplify docker service management.

wget dstart -o /usr/local/bin/dstart
wget dstop -o /usr/local/bin/dstop
wget dstopAll -o /usr/local/bin/dstopAll
wget dtail -o /usr/local/bin/dtail

cd /usr/local/bin
sudo chmod +x dstart
sudo chmod +x dstop
sudo chmod +x dstopAll
sudo chmod +x dtail