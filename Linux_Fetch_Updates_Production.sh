#!/bin/bash

source .env

# Check for any updates to the game server
cd Game
echo "Pulling recent updates from the Open-RSC Game repository."
echo ""
echo ""
sudo git pull
echo ""
echo ""

echo ""
echo ""
echo "Do you need to do manual file editing for the website domain and SQL user/pass?"
echo ""
echo "${RED}1${NC} - Yes, lets begin."
echo "${RED}2${NC} - Im all set"
echo ""
echo "Which of the above do you wish to do? Type the choice number and press enter."
echo ""
echo ""
read edit

if [ "$edit" == "1" ]; then
echo ""
echo ""
echo "(Use Ctrl + X to save each file when done editing) - Press enter when ready."
read next
sudo nano .env
sudo nano client/src/org/openrsc/client/Config.java
sudo nano Launcher/src/Main.java
sudo nano server/config/config.xml
echo ""
echo ""
echo "File edits complete. Restarting Docker containers."
echo ""
sudo make stop
sudo make start
fi

if [ "$edit" == "2" ]; then
echo ""
echo "Moving on..."
echo ""
echo ""
fi

#cd ../
#touch new_md5sum.txt
#tar -cf - Game | md5sum | grep -o '^[a-zA-Z0-9]*' > new_md5sum.txt
#cd Game

#if [ "(cat current_md5sum.txt)" == "(cat new_md5sum.txt)" ]; then
#    Echo "No file changes have been detected since last run."
#else
    # Compile server
    echo "Compiling the game server."
    echo ""
    echo ""
    sudo ant -f "server/build.xml" compile
    echo ""
    echo ""

    # Compile client
    echo "Compiling the game client."
    echo ""
    sudo ant -f "client/build.xml" compile
    echo ""
    echo ""
    echo "Compressing jar into zip"
    echo ""
    cd client
    sudo zip -r "client.zip" "Open_RSC_Client.jar"
    cd ../
    echo ""
    echo ""
    echo "Copying result to Website/downloads/"
    echo ""
    yes | sudo cp -rf "client/client.zip" "../Website/downloads/"
    sudo rm "client/client.zip"
    echo ""
    echo ""

    # Compile launcher
    echo "Compiling the game launcher."
    echo ""
    sudo ant -f "Launcher/build.xml" jar
    echo ""
    echo ""
    echo "Copying result to Website/downloads/"
    echo ""
    yes | sudo cp -rf "Launcher/dist/Open_RSC_Launcher.jar" "../Website/downloads/"
    echo ""
    echo ""

    # Cache
    echo "Copying Game/client/cache.zip to Website/downloads/"
    yes | sudo cp -rf "client/cache.zip" "../Website/downloads/"

    # MD5sum client.zip and cache.zip > hashes.txt
    cd ../
    sudo rm Website/downloads/hashes.txt
    md5sum Website/downloads/client.zip | grep ^[a-zA-Z0-9]* | awk '{print "client="$1}' | sudo tee -a Website/downloads/hashes.txt
    md5sum Website/downloads/cache.zip | grep ^[a-zA-Z0-9]* | awk '{print "cache="$1}' | sudo tee -a Website/downloads/hashes.txt

    # Replace the openrsc_config database with a fresh version
    echo ""
    echo ""
    echo "Importing fresh openrsc_config.sql database."
    echo ""
    sudo docker exec -i $(sudo docker-compose ps -q mysqldb) mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" < Game/Databases/openrsc_config.sql 2>/dev/null
#fi

# Run the game server in a detached screen
echo ""
echo ""
echo "Launching the game server in a new screen."
echo ""
echo "Type 'screen -r' to access the game server screen."
echo "Use CTRL + A + D to detach the live server screen so it runs in the background."
echo ""
echo ""
cd Game/server
screen -dmS name ./ant_launcher.sh
#cd ../../
#touch current_md5sum.txt
#tar -cf - Game | md5sum | grep -o '^[a-zA-Z0-9]*' > current_md5sum.txt
