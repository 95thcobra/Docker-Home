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

choice=""
RED=`tput setaf 1`
GREEN=`tput setaf 2`
NC=`tput sgr0` # No Color

# Install Choice ===================================================>
clear
echo "${RED}Open RSC Installer:${NC}
An easy to run RSC private server environment using Docker magic.

Do you wish to have all the pre-requiste software installed by this script?

Choices:
  ${RED}1${NC} - Yes please, install for me!
  ${RED}2${NC} - No thanks, continue (default)"
echo ""
echo "Which of the above do you wish to do? Type the choice number and press enter."
read install

# OS Selection ===================================================>
if [ "$install" == "1" ]; then
    clear
    echo "Which operating system are you running?"
    echo ""
    echo "${RED}1${NC} - Ubuntu Linux 18.04 or above"
    echo "${RED}2${NC} - Mac OS High Sierra or above"
    echo ""
    echo "Which of the above do you wish to do? Type the choice number and press enter."
    read os

    # Ubuntu OS ===================================================>
    if [ "$os" == "1" ]; then
        clear
        sudo dpkg-reconfigure tzdata

        clear
        echo "Verifying the basics are installed. Please wait."
        sudo apt-get update &>/dev/null
        sudo apt-get install software-properties-common -y &>/dev/null
        sudo add-apt-repository ppa:certbot/certbot -y &>/dev/null
        sudo apt-get update &>/dev/null
        sudo apt-get install certbot screen zip fail2ban unzip git build-essential apt-transport-https ca-certificates curl software-properties-common -y &>/dev/null

        clear
        echo "Attempting to install Docker now."
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &>/dev/null
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &>/dev/null
        sudo apt-get update &>/dev/null && sudo apt-get install docker-ce docker-compose -y &>/dev/null

        clear
        echo "Setting Docker to have the correct storage driver and reloading service."
        echo '{
    "storage-driver": "devicemapper"
}' | sudo tee /etc/docker/daemon.json && sudo service docker restart &>/dev/null

        clear
        echo "Configuring UFW."
        sudo ufw allow 22/tcp &>/dev/null && sudo ufw allow 80/tcp &>/dev/null && sudo ufw allow 8080/tcp &>/dev/null && sudo ufw allow 443/tcp &>/dev/null && sudo ufw allow 9000/tcp &>/dev/null && sudo ufw allow 53595/tcp &>/dev/null && sudo ufw deny 3306/tcp &>/dev/null
        sudo sed -i 's/DEFAULT_FORWARD_POLICY="DENY"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw &>/dev/null
        sudo ufw reload &>/dev/null
        sudo ufw --force enable &>/dev/null

        clear
        echo "Installing Oracle Java JDK 8 and other related packages."
        sudo apt-get remove -y openjdk-6-jre default-jre default-jre-headless &>/dev/null
        sudo add-apt-repository -y ppa:webupd8team/java &>/dev/null
        sudo apt update &>/dev/null
        sudo apt install -y openjfx ant &>/dev/null
        echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections &>/dev/null
        sudo apt-get install -y oracle-java8-installer &>/dev/null
        sudo apt install oracle-java8-set-default &>/dev/null
        fi
    # Ubuntu OS <===================================================

    # Mac OS ===================================================>
  elif [ "$os" == "2" ]; then
        clear
        echo "Do you have brew installed? It is required for this."
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        echo "Which of the above do you wish to do? Type the choice number and press enter."
        read brew

        # Mac Brew ===================================================>
        if [ "$brew" == "1" ]; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &>/dev/null
            brew install git &>/dev/null
        fi
        # Mac Brew <===================================================

        clear
        echo "Verifying the basics are installed."
        brew install unzip wget git curl zip screen &>/dev/null
        brew tap AdoptOpenJDK/openjdk &>/dev/null
        brew install adoptopenjdk-openjdk8 ant openjfx &>/dev/null

        clear
        echo "Downloading the Docker for Mac installer."
        wget https://download.docker.com/mac/stable/Docker.dmg &>/dev/null
        hdiutil attach Docker.dmg &>/dev/null
        echo ""
        echo "Please drag Docker as instructed in the popup."
        echo ""
        echo "Press enter when finished."
        read

        clear
        open /Applications/Docker.app
        echo "Docker is launching. Please follow the directions that it gives you."
        echo ""
        echo "Press enter when finished."
        read
        fi
    # Mac OS <===================================================
    # OS Selection <===================================================

# Install Choice <===================================================

clear
echo "Checking for updates to the Docker-Home repository."
sudo git pull &>/dev/null

clear
echo "${RED}Open RSC Installer:${NC}
An easy to run RSC private server using Docker magic.

Choices:
  ${RED}1${NC} - Set up for single player
  ${RED}2${NC} - Deployment for a publicly hosted server
  ${RED}3${NC} - Backup all SQL databases
"
echo ""
echo "Which of the above do you wish to do? Type the choice number and press enter."
read choice

# Selection ===================================================>
# 1. Set up for single player ===================================================>
if [ "$choice" == "1" ]; then
    clear
    echo "You have picked ${GREEN}set up for single player!${NC}"
    echo ""
    echo ""
    echo "Starting up the Docker containers."
    sudo make start-single-player &>/dev/null

    clear
    echo "Fetching the Game from the Open RSC git repo."
    sudo make clone-game &>/dev/null
    sudo chmod -R 777 Game &>/dev/null

    clear
    echo "Creating the client cache in your home folder."
    mkdir ~/OpenRSC &>/dev/null
    unzip -o Game/client/cache.zip -d ~/OpenRSC &>/dev/null

    clear
    echo "Importing the game databases."
    sudo make import-game &>/dev/null

    clear
    echo "Ready to launch \"./Linux_Single_Player.sh\" - Press enter when ready."
    read next
    ./Linux_Single_Player.sh
# 1. Set up for single player <===================================================

# 2. Deployment for a publicly hosted server ===================================================>
elif [ "$choice" == "2" ]; then
    clear
    echo "You have picked ${GREEN}deployment for a publicly hosted server!${NC}"
    echo ""
    echo ""
    echo "Starting up the Docker containers."
    sudo chmod -R 777 &>/dev/null
    sudo make start &>/dev/null

    clear
    echo "Fetching the Website and Game from the Open RSC git repo."
    sudo make clone-game &>/dev/null
    sudo make clone-website &>/dev/null
    sudo chmod -R 777 &>/dev/null

    clear
    echo "Creating the client cache in your home folder."
    mkdir ~/OpenRSC &>/dev/null
    unzip -o Game/client/cache.zip -d ~/OpenRSC &>/dev/null

    clear
    echo "Next is manual file editing for the website domain and SQL user/pass."
    echo ""
    echo "It is suggested that you first navigate to your VPS's http://domain:9000"
    echo ""
    echo "Create a new SQL user and password, grant all permissions, then remove the others."
    echo ""
    echo ""
    echo "When finished, it will be time to edit the files that rely on that new SQL user."
    echo ""
    echo "(Use Ctrl + X to save each file when done editing) - Press enter when ready."
    read next
    sudo nano .env
    sudo nano Game/client/src/org/openrsc/client/Config.java
    sudo nano Game/Launcher/src/Main.java
    sudo nano Game/server/config/config.xml
    sudo nano etc/ghost/config.production.json

    clear
    echo "Importing the databases."
    sudo make import-game &>/dev/null
    sudo make import-ghost &>/dev/null

    clear
    echo "Restarting Ghost container."
    sudo docker stop ghost && sudo docker start ghost &>/dev/null

    clear
    echo "Ready to launch \"./Linux_Fetch_Updates_Production.sh\" - Press enter when ready."
    read next
    ./Linux_Fetch_Updates_Production.sh
# 2. Deployment for a publicly hosted server <===================================================

# 3. Backup ===================================================>
elif [ "$choice" == "3" ]; then

  echo "You have picked ${GREEN}backup all SQL databases!${NC}"
  sudo make backup &>/dev/null
  clear
  echo "Done! - Press enter to return back to the menu."
  read
  ./Linux_Installer.sh
# 3. Backup <===================================================

else
    clear
    echo "Error! ${RED}$choice${NC} is not a valid option. Press enter to try again."
    echo ""
    read
    ./Linux_Installer.sh
fi
# Selection <===================================================
