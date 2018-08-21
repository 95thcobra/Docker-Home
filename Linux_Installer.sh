clear
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
echo ""
echo ""
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
    echo ""
    echo ""
    read os

    # Ubuntu OS ===================================================>
    if [ "$os" == "1" ]; then
        clear
        sudo dpkg-reconfigure tzdata

        clear
        echo "Verifying the basics are installed."
        echo ""
        sudo apt-get update
        sudo apt-get install software-properties-common -y
        sudo add-apt-repository ppa:certbot/certbot -y
        sudo apt-get update
        sudo apt-get install certbot screen zip fail2ban unzip git build-essential apt-transport-https ca-certificates curl software-properties-common -y

        clear
        echo "Attempting to install Docker now"
        echo ""
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
        sudo apt-get update && sudo apt-get install docker-ce docker-compose -y

        clear
        echo "Setting Docker to have the correct storage driver and reloading service."
        echo ""
        echo '{
    "storage-driver": "devicemapper"
}' | sudo tee /etc/docker/daemon.json && sudo service docker restart

        clear
        echo "Configuring UFW."
        echo ""
        sudo ufw allow 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 8080/tcp && sudo ufw allow 443/tcp && sudo ufw allow 9000/tcp && sudo ufw allow 53595/tcp && sudo ufw deny 3306/tcp
        sudo sed -i 's/DEFAULT_FORWARD_POLICY="DENY"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
        sudo ufw reload
        sudo ufw --force enable

        clear
        echo "Installing Oracle Java JDK 8"
        echo ""
        sudo apt-get remove openjdk-6-jre default-jre default-jre-headless -y
        echo ""
        sudo add-apt-repository ppa:webupd8team/java -y && sudo apt update && sudo apt install ant oracle-java8-set-default openjfx -y
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
        echo ""
        echo ""
        read brew

        # Mac Brew ===================================================>
        if [ "$brew" == "1" ]; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew install git
        fi
        # Mac Brew <===================================================

        clear
        echo "Verifying the basics are installed."
        echo ""
        brew install unzip wget git curl zip screen
        brew tap AdoptOpenJDK/openjdk
        brew install adoptopenjdk-openjdk8 ant openjfx

        clear
        echo "Downloading the Docker for Mac installer."
        echo ""
        wget https://download.docker.com/mac/stable/Docker.dmg
        hdiutil attach Docker.dmg
        echo ""
        echo "Please drag Docker as instructed in the popup."
        echo ""
        echo "Press enter when finished."
        echo ""
        read

        clear
        open /Applications/Docker.app
        echo ""
        echo "Docker is launching. Please follow the directions that it gives you."
        echo ""
        echo "Press enter when finished."
        echo ""
        read
        fi
    # Mac OS <===================================================
    # OS Selection <===================================================

# Install Choice <===================================================

clear
echo "Checking for updates to the Docker-Home repository."
echo ""
sudo git pull

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
echo ""
echo ""
read choice

# Selection ===================================================>
# 1. Set up for single player ===================================================>
if [ "$choice" == "1" ]; then
    clear
    echo "You have picked ${GREEN}set up for single player!${NC}"
    echo ""
    echo ""
    echo "Starting up the Docker containers. If error, do \"sudo make stop\" and rerun script."
    echo ""
    sudo make start-single-player

    clear
    echo "Fetching the Game from the Open RSC git repo."
    echo ""
    sudo make clone-game
    sudo chmod -R 777 Game

    clear
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC

    clear
    echo "Importing the game databases."
    echo ""
    sudo make import-game

    clear
    echo "Ready to launch \"./Linux_Single_Player.sh\" - Press enter when ready."
    echo ""
    echo ""
    read next
    ./Linux_Single_Player.sh
# 1. Set up for single player <===================================================

# 2. Deployment for a publicly hosted server ===================================================>
elif [ "$choice" == "2" ]; then
    clear
    echo "You have picked ${GREEN}deployment for a publicly hosted server!${NC}"
    echo ""
    echo ""
    echo "Starting up the Docker containers. If error, do \"sudo make stop\" and rerun script."
    echo ""
    sudo chmod -R 777 .
    sudo make start

    clear
    echo "Fetching the Website and Game from the Open RSC git repo."
    echo ""
    sudo make clone-game
    sudo make clone-website
    sudo chmod -R 777 .

    clear
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC

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
    echo ""
    sudo make import-game
    sudo make import-ghost

    clear
    echo "Restarting Docker containers"
    echo ""
    sudo make stop && sudo make start

    clear
    echo "Ready to launch \"./Linux_Fetch_Updates_Production.sh\" - Press enter when ready."
    echo ""
    echo ""
    read next
    ./Linux_Fetch_Updates_Production.sh
# 2. Deployment for a publicly hosted server <===================================================

# 3. Backup ===================================================>
elif [ "$choice" == "3" ]; then

  echo "You have picked ${GREEN}backup all SQL databases!${NC}"
  echo ""
  echo ""
  sudo make backup
  echo ""
  echo ""
  echo "Done! - Press enter to return back to the menu."
  echo ""
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
