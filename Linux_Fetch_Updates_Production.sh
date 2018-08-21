#!/bin/bash

source .env

# Check for any updates to the game server
clear
echo "Pulling recent updates from the Open-RSC Game repository."
echo ""
echo ""
cd Game
sudo git pull
echo ""
# Verifies permissions are set correctly
sudo chmod -R 777 Game
sudo setfacl -m user:$USER:rw /var/run/docker.sock
cd ..

clear
echo "Do you need to do any manual file editing?"
echo ""
echo "${RED}1${NC} - Yes, lets begin."
echo "${RED}2${NC} - No, continue."
echo ""
echo "Which of the above do you wish to do? Type the choice number and press enter."
echo ""
echo ""
read edit

if [ "$edit" == "1" ]; then
clear
sudo nano .env
sudo nano Game/client/src/org/openrsc/client/Config.java
sudo nano Game/Launcher/src/Main.java
sudo nano Game/server/config/config.xml
sudo nano etc/ghost/config.production.json
sudo make stop && sudo make start
fi

if [ "$edit" == "2" ]; then
echo ""
fi

# Server
cd Game
clear
echo "Preparing the game server."
echo ""
sudo ant -f "server/build.xml" compile

# Client
clear
echo "Preparing the game client."
echo ""
sudo ant -f "client/build.xml" compile
cd client
sudo zip -r "client.zip" "Open_RSC_Client.jar"
cd ../
yes | sudo cp -rf "client/client.zip" "../Website/downloads/"
sudo rm "client/client.zip"

# Launcher
clear
echo "Preparing the game launcher."
echo ""
sudo ant -f "Launcher/build.xml" jar
yes | sudo cp -rf "Launcher/dist/Open_RSC_Launcher.jar" "../Website/downloads/"

# Cache
clear
echo "Preparing the cache."
yes | sudo cp -rf "client/cache.zip" "../Website/downloads/"
cd ..
sudo rm Website/downloads/hashes.txt
md5sum Website/downloads/client.zip | grep ^[a-zA-Z0-9]* | awk '{print "client="$1}' | sudo tee -a Website/downloads/hashes.txt
md5sum Website/downloads/cache.zip | grep ^[a-zA-Z0-9]* | awk '{print "cache="$1}' | sudo tee -a Website/downloads/hashes.txt

# Database
clear
echo "Preparing the database."
echo ""
docker exec -i $(sudo docker-compose ps -q mysqldb) mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" < Game/Databases/openrsc_config.sql 2>/dev/null

# Run the game server in a detached screen
sudo ./Linux_Run_Production_Server.sh
