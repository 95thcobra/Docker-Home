#!/bin/bash
exec 0</dev/tty

# Open RSC: A replica RSC private server framework
#
# Installs and updates Open RSC
#
# Install with this command (from your Linux machine):
#
# curl -sSL https://raw.githubusercontent.com/Open-RSC/Docker-Home/master/Linux_Cloner.sh | bash

source .env

rm updater.log
touch updater.log && chmod 777 updater.log | tee updater.log | &>/dev/null

# Check for any updates to the game server
clear
echo "Pulling recent updates from the Open-RSC Game repository."
cd Game
sudo git pull | tee -a ../updater.log &>/dev/null

# Verifies permissions are set correctly
sudo chmod -R 777 Game | tee -a ../updater.log &>/dev/null
sudo setfacl -m user:$USER:rw /var/run/docker.sock | tee -a ../updater.log &>/dev/null
cd ..

clear
echo "Do you need to do any manual file editing?"
echo ""
echo "${RED}1${NC} - Yes, lets begin."
echo "${RED}2${NC} - No, continue."
echo ""
echo "Which of the above do you wish to do? Type the choice number and press enter."
read edit

if [ "$edit" == "1" ]; then
clear
sudo nano .env
sudo nano Game/client/src/org/openrsc/client/Config.java
sudo nano Game/Launcher/src/Main.java
sudo nano Game/server/config/config.xml

clear
echo "Restarting Ghost container"
sudo docker stop ghost && sudo docker start ghost | tee -a updater.log &>/dev/null
fi

if [ "$edit" == "2" ]; then
echo ""
fi

# Server
cd Game
clear
echo "Compiling the game server. Any errors will be in updater.log"
sudo ant -f "server/build.xml" compile | tee ../updater.log &>/dev/null

# Client
clear
echo "Compiling and preparing the game client. Any errors will be in updater.log"
sudo ant -f "client/build.xml" compile | tee -a ../updater.log &>/dev/null
cd client
sudo zip -r "client.zip" "Open_RSC_Client.jar" | tee -a ../../updater.log &>/dev/null
cd ../
yes | sudo cp -rf "client/client.zip" "../Website/downloads/" | tee -a ../updater.log &>/dev/null
sudo rm "client/client.zip" | tee -a ../updater.log &>/dev/null

# Launcher
clear
echo "Compiling and preparing the game launcher. Any errors will be in updater.log"
sudo ant -f "Launcher/build.xml" jar | tee -a ../updater.log &>/dev/null
yes | sudo cp -rf "Launcher/dist/Open_RSC_Launcher.jar" "../Website/downloads/" | tee -a updater.log &>/dev/null

# Cache
clear
echo "Preparing the cache."
yes | sudo cp -rf "client/cache.zip" "../Website/downloads/" | tee -a ../updater.log &>/dev/null
cd ..
sudo rm Website/downloads/hashes.txt | tee -a updater.log &>/dev/null
md5sum Website/downloads/client.zip | grep ^[a-zA-Z0-9]* | awk '{print "client="$1}' | sudo tee -a Website/downloads/hashes.txt | tee -a updater.log &>/dev/null
md5sum Website/downloads/cache.zip | grep ^[a-zA-Z0-9]* | awk '{print "cache="$1}' | sudo tee -a Website/downloads/hashes.txt | tee -a updater.log &>/dev/null

# Database
clear
echo "Preparing the database."
docker exec -i $(sudo docker-compose ps -q mysqldb) mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" < Game/Databases/openrsc_config.sql 2>/dev/null

# Run the game server in a detached screen
./Linux_Run_Production_Server.sh
