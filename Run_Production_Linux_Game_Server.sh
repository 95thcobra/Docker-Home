#!/bin/bash

# Check for any updates to the game server
echo "Pulling recent updates from the Open-RSC Game repository."
echo ""
echo ""
sudo make pull-game
echo ""
echo ""

# Compile the game server
echo "Compiling the game server."
echo ""
echo ""
sudo ant -f Game/server/build.xml compile
echo ""
echo ""

# Client
echo "Compiling the game client."
echo ""
sudo ant -f "Game/client/build.xml" compile
echo ""
echo ""
echo "Compressing jar into zip"
echo ""
cd Game/client
sudo zip -r "client.zip" "Open_RSC_Client.jar"
cd ../../
echo ""
echo ""
echo "Copying result to Website/downloads/"
echo ""
yes | sudo cp -rf "Game/client/client.zip" "Website/downloads/"
sudo rm "Game/client/client.zip"
echo ""
echo ""

# Launcher
echo "Compiling the game launcher."
echo ""
sudo ant -f "Game/Launcher/build.xml"
echo ""
echo ""
echo "Copying result to Website/downloads/"
echo ""
yes | sudo cp -rf "Game/Launcher/dist/Open_RSC_Launcher.jar" "Website/downloads/"
echo ""
echo ""

# Cache
echo "Copying Game/client/cache.zip to Website/downloads/"
yes | sudo cp -rf "Game/client/cache.zip" "Website/downloads/"

# MD5sum client.zip and cache.zip > hashes.txt
sudo rm Website/downloads/hashes.txt
md5sum Website/downloads/client.zip | grep ^[a-zA-Z0-9]* | awk '{print "client="$1}' | sudo tee -a Website/downloads/hashes.txt
md5sum Website/downloads/cache.zip | grep ^[a-zA-Z0-9]* | awk '{print "cache="$1}' | sudo tee -a Website/downloads/hashes.txt

# Run the game server in a detached screen
echo "Importing fresh openrsc_config.sql database."
echo ""
sudo docker exec -i $(sudo docker-compose ps -q mysqldb) mysql -u"root" -p"root" < Game/Databases/openrsc_config.sql 2>/dev/null
echo ""
echo ""
echo "Launching the game server in a new screen."
echo ""
echo "Type 'screen -r' to access the game server screen."
echo "Use CTRL + A + D to detach the live server screen so it runs in the background."
echo ""
echo ""
screen -dmS name ./ant_launcher.sh
