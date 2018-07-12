#!/bin/bash
clear
git pull
docker login
sudo make stop
sudo make start
sudo make clone
sudo make import
mkdir ~/OpenRSC
unzip Game/client/cache.zip -d ~/OpenRSC
