#!/bin/bash

# Verifies permissions are set correctly
sudo chmod -R 777 Game
sudo setfacl -m user:$USER:rw /var/run/docker.sock

# Backs up all databases
./Linux_Backup_Databases.sh

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
