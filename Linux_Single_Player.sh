#!/bin/bash

source .env

# Check for any updates to the game server
clear
echo "Pulling recent updates from the Open-RSC Game repository."
sudo git pull &>/dev/null
sudo make pull-game &>/dev/null

clear
echo "Starting Docker containers."
sudo make stop &>/dev/null
sudo make start-single-player &>/dev/null

# Compile the game server and client
clear
echo "Compiling the game client. Any errors will be in compile.log"
touch compile.log && chmod 777 compile.log &>/dev/null
sudo ant -f "Game/client/build.xml" compile | tee compile.log &>/dev/null

clear
echo "Compiling the game server. Any errors will be in compile.log"
sudo ant -f "Game/server/build.xml" compile | tee -a compile.log &>/dev/null

#Create game cache
clear
echo "Removing old cache if exists and then extracting a fresh client cache to your home folder."
sudo rm -rf ~/OpenRSC &>/dev/null
mkdir ~/OpenRSC &>/dev/null
unzip -o Game/client/cache.zip -d ~/OpenRSC >/dev/null

#Import fresh version of config database
clear
echo "Importing a fresh openrsc_config.sql database."
sudo docker exec -i $(sudo docker-compose ps -q mysqldb) mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" < Game/Databases/openrsc_config.sql 2>/dev/null

#Generate updated cache files, copies them to cache folder overwriting existing
clear
echo "Generating cache .dat files from current config database and copying to client cache in your home folder."
sudo ant -f Game/server/build.xml npcs items objects &>/dev/null
yes | cp -rf Game/server/npcs.dat ~/OpenRSC/npcs.dat &>/dev/null
yes | cp -rf Game/server/objects.dat ~/OpenRSC/objects.dat &>/dev/null
yes | cp -rf Game/server/items.dat ~/OpenRSC/items.dat &>/dev/null

# Run the game client in a new window
clear
echo "Launching the game client."
#ant -f Game/client/build.xml runclient &
java -jar Game/client/Open_RSC_Client.jar &

# Run the game server in the current window
clear
echo "Launching the game server."
cd Game/server
java -jar Open_RSC_Server.jar
