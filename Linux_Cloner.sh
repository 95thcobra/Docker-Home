#!/usr/bin/env bash
# shellcheck disable=SC1090

# Open RSC: A replica RSC private server framework
#
# Installs and updates Open RSC
#
# Install with this command (from your Linux machine):
#
# curl -sSL https://raw.githubusercontent.com/Open-RSC/Docker-Home/master/Linux_Cloner.sh | bash

# -e option instructs bash to immediately exit if any command [1] has a non-zero exit status
# We do not want users to end up with a partially working install, so we exit the script
# instead of continuing the installation with something broken

cd /
sudo git clone https://github.com/Open-RSC/Docker-Home.git &>/dev/null
cd Docker-Home
./Linux_Installer
