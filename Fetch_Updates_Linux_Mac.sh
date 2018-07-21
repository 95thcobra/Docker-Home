#!/bin/bash

echo ""
echo "Fetching updates to local repositories."
echo ""
sudo make pull-game
sudo make pull-website
sudo make pull-wiki
echo ""
