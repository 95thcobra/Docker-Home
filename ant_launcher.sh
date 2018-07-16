#!/bin/bash
echo "Pulling recent updates from the Open-RSC Game repo"
sudo make pull
echo ""
echo ""

#Compile
echo "Compiling the game server"
echo ""
echo ""
sudo Ant/bin/ant -f Game/server/build.xml compile

#Run game server
echo "Launching the game server"
echo ""
echo ""
Ant/bin/ant -f Game/server/build.xml runserver
