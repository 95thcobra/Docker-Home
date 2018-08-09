#!/bin/bash

echo ""
echo "Fetching updates to local repositories."
echo ""
sudo git pull
sudo make pull-game
sudo make pull-website
echo ""
