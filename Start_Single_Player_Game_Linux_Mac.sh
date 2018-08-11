#!/bin/bash

# Check for any updates to the game server
echo ""
echo "Pulling recent updates from the Open-RSC Game repository."
echo ""
sudo git pull
sudo make pull-game
echo ""
echo ""
echo "Starting Docker containers."
echo ""
sudo make start-single-player
echo ""
echo ""

# Compile the game server and client
echo "Compiling the game client."
echo ""
sudo ant -f Game/client/build.xml compile
echo ""
echo ""
echo "Compiling the game server."
echo ""
sudo ant -f Game/server/build.xml compile
echo ""
echo ""

#Create game cache
echo "Removing old then extracting a fresh client cache to your home folder."
echo ""
sudo rm -rf ~/OpenRSC
mkdir ~/OpenRSC
unzip -o Game/client/cache.zip -d ~/OpenRSC
echo ""
echo ""

#Import fresh version of config database
echo "Importing a fresh openrsc_config.sql database."
echo ""
sudo docker exec -i $(sudo docker-compose ps -q mysqldb) mysql -u"root" -p"root" < Game/Databases/openrsc_config.sql 2>/dev/null
echo ""
echo ""

#Generate updated cache files, copies them to cache folder overwriting existing
echo "Generating cache .dat files from current config database and copying to client cache in your home folder."
echo ""
sudo ant -f Game/server/build.xml npcs items objects > /dev/null
yes | cp -rf Game/server/npcs.dat ~/OpenRSC/npcs.dat
yes | cp -rf Game/server/objects.dat ~/OpenRSC/objects.dat
yes | cp -rf Game/server/items.dat ~/OpenRSC/items.dat
echo ""
echo ""

# Run the game client in a new window
echo "Launching the game client."
echo ""
ant -f Game/client/build.xml runclient &
echo ""
echo ""

# Run the game server in the current window
echo "Launching the game server."
echo ""
ant -f Game/server/build.xml runserver
echo ""
