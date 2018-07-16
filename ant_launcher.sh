#!/bin/bash

# Run the game server
echo ""
echo "Running the game server. Press CTRL + C to shut it down or"
echo "CTRL + A + D to detached the screen so this runs in the background."
echo ""
echo ""
Ant/bin/ant -f Game/server/build.xml runserver
