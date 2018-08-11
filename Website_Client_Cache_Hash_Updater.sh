#!/bin/bash

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
