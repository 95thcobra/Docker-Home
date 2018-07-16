#!/bin/bash

# Check for any updates to the game server
echo ""
echo "Pulling recent updates from the Open-RSC Game repository."
echo ""
sudo make pull
echo ""
echo ""
echo "Starting any stopped Docker containers."
echo ""
sudo make start
echo ""
echo ""

# Compile the game server and client
echo "Compiling the game client."
echo ""
sudo Ant/bin/ant -f Game/client/build.xml compile
echo ""
echo ""
echo "Compiling the game server."
echo ""
sudo Ant/bin/ant -f Game/server/build.xml compile
echo ""
echo ""

# Rune the game client in a new window
echo "Launching the game client."
echo ""
Ant/bin/ant -f Game/client/build.xml runclient &
echo ""
echo ""

# Run the game server in the current window
echo "Launching the game server."
echo ""
Ant/bin/ant -f Game/server/build.xml runserver
echo ""
