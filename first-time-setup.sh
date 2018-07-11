#!/bin/bash
clear
docker login
sudo make stop
sudo make start
sudo make clone
sleep 5
sudo make import
mkdir ~/OpenRSC
unzip Game/Open-RSC-Game/client/cache.zip -d ~/OpenRSC
