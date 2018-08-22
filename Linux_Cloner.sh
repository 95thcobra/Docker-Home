#!/bin/bash

# Open RSC: A replica RSC private server framework
#
# Installs and updates Open RSC
#
# Install with this command (from your Linux machine):
#
# curl -sSL https://raw.githubusercontent.com/Open-RSC/Docker-Home/master/Linux_Cloner.sh | bash

cd /
sudo git clone https://github.com/Open-RSC/Docker-Home.git &>/dev/null
cd Docker-Home
./Linux_Installer
