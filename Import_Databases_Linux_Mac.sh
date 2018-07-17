#!/bin/bash

echo ""
echo "Attempting to import (or overwrite) the game database."
echo ""
sudo make import-game
echo ""
echo ""
echo "Attempting to import (or overwrite) the website database."
echo ""
sudo make import-website
echo ""
echo ""
echo "Attempting to import (or overwrite) the wiki database."
echo ""
sudo make import-wiki
echo ""
