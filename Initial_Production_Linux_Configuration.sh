#!/bin/bash

# Pull
echo "Pulling updates from repositories."
sudo git pull
cd Game
sudo git pull
cd ..
cd Website
sudo git pull
cd ..
echo ""
echo ""

# Manual edits
echo "Manual java file edits are next. Press enter to begin."
read next
sudo nano Game/client/src/org/openrsc/client/Config.java
sudo nano Game/Launcher/src/Main.java
sudo nano Run_Production_Linux_Game_Server.sh
echo ""
echo ""
echo "Launching Run_Production_Linux_Game_Server.sh"
echo ""
echo ""
./Run_Production_Linux_Game_Server.sh
