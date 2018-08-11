#!/bin/bash

# Client
echo "Compiling the game client."
echo ""
ant -f "Game/client/build.xml" compile
echo ""
echo ""
echo "Compressing jar into zip"
echo ""
cd Game/client
zip -r "client.zip" "Open_RSC_Client.jar"
cd ../../
echo ""
echo ""
echo "Copying result to Website/downloads/"
echo ""
yes | cp -rf "Game/client/client.zip" "Website/downloads/"
rm "Game/client/client.zip"

echo ""
echo ""

# Launcher
echo "Compiling the game launcher."
echo ""
ant -f "Game/Launcher/build.xml"
echo ""
echo ""
echo "Copying result to Website/downloads/"
echo ""
yes | cp -rf "Game/Launcher/dist/Open_RSC_Launcher.jar" "Website/downloads/"
echo ""
echo ""

# Cache
echo "Copying Game/client/cache.zip to Website/downloads/"
yes | cp -rf "Game/client/cache.zip" "Website/downloads/"

# MD5sum client.zip and cache.zip > hashes.txt
rm Website/downloads/hashes.txt
md5sum Website/downloads/client.zip | grep ^[a-zA-Z0-9]* | awk '{print "client="$1}' | tee -a Website/downloads/hashes.txt
md5sum Website/downloads/cache.zip | grep ^[a-zA-Z0-9]* | awk '{print "cache="$1}' | tee -a Website/downloads/hashes.txt
