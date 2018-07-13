clear
choice=""
RED=`tput setaf 1`
GREEN=`tput setaf 2`
NC=`tput sgr0` # No Color

echo "${RED}Open RSC Installer:${NC}
An easy to run RSC private server environment using Docker magic.

Before continuing, Open RSC needs to know if you have Docker, and Git installed.
This installer can install one or both for you if needed.

Choices:
  ${RED}1${NC} - Install for me!
  ${RED}2${NC} - I'm all set, continue! (default)"
echo ""
read install

if [ "$install" == "1" ]; then
    clear
    echo "Which operating system are you running?"
    echo ""
    echo "${RED}1${NC} - Ubuntu Linux"
    echo "${RED}2${NC} - Fedora Linux"
    echo "${RED}3${NC} - Mac OS"
    echo "${RED}4${NC} - Other"
    echo ""
    read os

    if [ "$os" == "1" ]; then
        sudo apt-get update && sudo apt-get install git build-essential apt-transport-https ca-certificates curl software-properties-common -y
    elif [ "$os" == "2" ]; then
        su -c 'yum update && yum install git'
    elif [ "$os" == "3" ]; then
        clear
        echo "Do you have brew installed?"
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read brew

        if [ "$brew" == "1" ]; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew install git
        else
            continue
        fi
    elif [ "$os" == "4" ]; then
        echo ""
        echo "You will have to install Git manually then. Press enter to continue."
        echo ""
        read
    else
        continue
    fi

    echo "Attempting to install Docker now"
        curl -fsSL get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo apt install docker-compose
    else
        continue
    fi

clear
echo "Checking the Docker Home git repo for any recent updates."
echo ""
git pull
echo ""
clear
echo "${RED}Open RSC Installer:${NC}
An easy to run RSC private server environment using Docker magic.

Choices:
  ${RED}1${NC} - Single player RSC game + basic database editing (using PHPMyAdmin)
  ${RED}2${NC} - Game + Website + PHPMyAdmin
  ${RED}3${NC} - Game + Website + PHPMyAdmin + RSC Preservation Wiki

Which of the above do you want? Type 1, 2, or 3, and press enter."
echo ""
read choice

if [ "$choice" == "1" ]; then
    clear
    echo "You have picked ${GREEN}single player RSC + PHPMyAdmin!${NC}"
    echo ""
    echo ""
    echo "Checking the git repos for any recent updates."
    echo ""
    echo "You may now be prompted for your password so the installer has sudo access."
    echo ""
    sudo make pull-game
    echo ""
    echo ""
    echo "Logging into Docker Hub to get the required images."
    echo "You may first need to register an account at ${RED}dockerhub.com${NC}"
    echo ""
    docker login
    echo ""
    echo ""
    echo "Starting up the Docker containers and stopping any existing ones."
    echo ""
    sudo make stop
    echo ""
    sudo make start
    echo ""
    echo ""
    echo "Fetching the Website and Game from the Open RSC git repo."
    echo ""
    sudo make clone-game
    echo ""
    echo ""
    echo "Importing the databases."
    echo ""
    sudo make import
    echo ""
    echo ""
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC
    echo ""
    echo ""
    echo "Open RSC setup complete!"
    echo ""
    exit

elif [ "$choice" == "2" ]; then
    clear
    echo "You have picked ${GREEN}Game + Website + PHPMyAdmin!${NC}"
    echo ""
    echo ""
    echo "Checking the git repos for any recent updates."
    echo ""
    echo "You may now be prompted for your password so the installer has sudo access."
    echo ""
    sudo make pull-game
    echo ""
    sudo make pull-website
    echo ""
    echo ""
    echo "Logging into Docker Hub to get the required images."
    echo "You may first need to register an account at ${RED}dockerhub.com${NC}"
    echo ""
    docker login
    echo ""
    echo ""
    echo "Starting up the Docker containers and stopping any existing ones."
    echo ""
    sudo make stop
    echo ""
    sudo make start
    echo ""
    echo ""
    echo "Fetching the Website and Game from the Open RSC git repo."
    echo ""
    sudo make clone-game
    echo ""
    sudo make clone-website
    echo ""
    echo ""
    echo "Importing the databases."
    echo ""
    sudo make import
    echo ""
    echo ""
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC
    echo ""
    echo ""
    echo "Open RSC setup complete!"
    echo ""
    exit

elif [ "$choice" == "3" ]; then
    clear
    echo "You have picked ${GREEN}Game + Website + PHPMyAdmin + RSC Preservation Wiki!${NC}"
    echo ""
    echo ""
    echo "Checking the git repos for any recent updates."
    echo ""
    echo "You may now be prompted for your password so the installer has sudo access."
    echo ""
    sudo make pull-game
    echo ""
    sudo make pull-website
    echo ""
    sudo make pull-wiki
    echo ""
    echo ""
    echo "Logging into Docker Hub to get the required images."
    echo "You may first need to register an account at ${RED}dockerhub.com${NC}"
    echo ""
    docker login
    echo ""
    echo ""
    echo "Starting up the Docker containers and stopping any existing ones."
    echo ""
    sudo make stop
    echo ""
    sudo make start
    echo ""
    echo ""
    echo "Fetching the Website, Game, and Wiki from the Open RSC git repo."
    echo ""
    sudo make clone-game
    echo ""
    sudo make clone-website
    echo ""
    sudo make clone-wiki
    echo ""
    echo ""
    echo "Extracting the Wiki database."
    echo ""
    unzip -o Website/Wiki/openrsc_wiki.sql.zip -d Website/Wiki
    echo ""
    echo ""
    echo "Importing the game, forum, and wiki databases."
    echo ""
    sudo make import
    echo ""
    sudo make import-wiki
    echo ""
    echo ""
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC
    echo ""
    echo ""
    echo "Open RSC setup complete!"
    echo ""
    exit

else
    echo ""
    echo "Error! ${RED}$choice${NC} is not a valid option. Press enter to try again."
    echo ""
    read
    ./Setup_Linux.sh
fi
