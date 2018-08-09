#!/bin/bash

# Run the game server
echo ""
echo "Running the game server. Press CTRL + C to shut it down or"
echo "CTRL + A + D to detached the screen so this runs in the background."
echo ""
echo "Console output is being saved to gameserver.log"
echo ""
ant -f Game/server/build.xml runserver > gameserver.log
