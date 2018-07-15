clear
choice=""
RED=`tput setaf 1`
GREEN=`tput setaf 2`
NC=`tput sgr0` # No Color

# Install Choice ===================================================>
echo "${RED}Open RSC Installer:${NC}
An easy to run RSC private server environment using Docker magic.

Before continuing, Open RSC needs to know if you have Java, Docker, and Git installed.
This installer can install one or both for you if needed.

Choices:
  ${RED}1${NC} - Install for me!
  ${RED}2${NC} - Im all set, continue! (default)"
echo ""
read install

# OS Selection ===================================================>
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

    # Ubuntu OS ===================================================>
    if [ "$os" == "1" ]; then
        echo ""
        echo "Which Ubuntu Linux version are you running?"
        echo ""
        echo "${RED}1${NC} - 16.04"
        echo "${RED}2${NC} - 16.10"
        echo "${RED}3${NC} - 17.04"
        echo "${RED}4${NC} - 17.10"
        echo "${RED}5${NC} - 18.04"
        echo "${RED}6${NC} - 18.10"
        echo ""
        read ubuntu

        # Ubuntu Version ===================================================>
        if [ "$ubuntu" == "1" ]; then
            vers="xenial"
        elif [ "$ubuntu" == "2" ]; then
            vers="yakkety"
        elif [ "$ubuntu" == "3" ]; then
            vers="zesty"
        elif [ "$ubuntu" == "4" ]; then
            vers="artful"
        elif [ "$ubuntu" == "5" ]; then
            vers="bionic"
        elif [ "$ubuntu" == "6" ]; then
            vers="cosmic"
        else
            vers="bionic"
            continue
        fi
        # UBUNTU Version <===================================================

        echo ""
        echo ""
        echo "Do you have Docker installed?"
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # Ubuntu Docker ===================================================>
        if [ "$docker" == "1" ]; then
            echo "Attempting to install Docker now"
            echo ""
            sudo apt update && sudo apt install git build-essential apt-transport-https ca-certificates curl software-properties-common -y
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $vers stable"
            sudo apt update && sudo apt install docker-ce docker-compose -y
        else
          continue
        fi
        # Ubuntu Docker <===================================================

        echo ""
        echo ""
        echo "Do you have Java OpenJDK installed already?"
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # Ubuntu Java ===================================================>
        if [ "$java" == "1" ]; then
            sudo apt update && sudo apt install default-jdk ant openjfx -y
        else
          continue
        fi
        # Ubuntu Java <===================================================
    # Ubuntu OS <===================================================

    # Fedora OS ===================================================>
    elif [ "$os" == "2" ]; then
        su -c 'yum update && yum install git'
        echo ""
        echo ""
        echo "Do you have Java OpenJDK installed already?"
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # Fedora Java ===================================================>
        if [ "$java" == "1" ]; then
            su -c 'yum install alternatives'
            su -c '/usr/sbin/alternatives --config java'
        else
          continue
        fi
        # Fedora Java <===================================================

        echo ""
        echo ""
        echo "Do you have Docker installed?"
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # Fedora Docker ===================================================>
        if [ "$docker" == "1" ]; then
            echo "Attempting to install Docker now"
            echo ""
            curl -fsSL get.docker.com -o get-docker.sh
            su -c 'sh get-docker.sh'
        else
          continue
        fi
        # Fedora Docker <===================================================
    # Fedora OS <===================================================

    # Mac OS ===================================================>
    elif [ "$os" == "3" ]; then
        clear
        echo "Do you have brew installed?"
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read brew

        # Mac Brew ===================================================>
        if [ "$brew" == "1" ]; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew install git
        fi
        # Mac Brew <===================================================

        echo ""
        echo ""
        echo "Do you have Java OpenJDK 8 installed already?"
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # Mac Java ===================================================>
        if [ "$java" == "1" ]; then
            brew tap AdoptOpenJDK/openjdk
            brew install adoptopenjdk-openjdk8
        fi
        # Mac Java <===================================================

        echo ""
        echo ""
        echo "Do you have Docker installed?"
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # Mac Docker ===================================================>
        if [ "$docker" == "1" ]; then
            echo "Downloading the Docker for Mac installer"
            brew install wget
            wget https://download.docker.com/mac/stable/Docker.dmg
            hdiutil attach Docker.dmg
            echo ""
            echo "Please drag Docker as instructed in the popup."
            echo ""
            echo "Press enter when finished."
            echo ""
            read
            echo ""
            open /Applications/Docker.app
            echo ""
            echo "Docker is launching. Please follow the directions that it gives you."
            echo ""
            echo "Press enter when finished."
            echo ""
            read
        fi
        # Mac Docker <===================================================
    # Mac OS <===================================================

    # Other OS ===================================================>
    elif [ "$os" == "4" ]; then
        echo ""
        echo "You will have to install Git manually then. Press enter to continue."
        echo ""
        read
        echo ""
        echo "Do you have Docker installed?"
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # Other OS Docker ===================================================>
        if [ "$docker" == "1" ]; then
            echo "Attempting to install Docker now"
            echo ""
            curl -fsSL get.docker.com -o get-docker.sh
            sudo sh get-docker.sh
        else
          continue
        fi
        # Other OS Docker <===================================================

        echo ""
        echo ""
        echo "Do you have Java OpenJDK installed already?"
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # Other OS Java ===================================================>
        if [ "$java" == "1" ]; then
            sudo apt update && sudo apt install default-jdk ant openjfx -y
        else
          continue
        fi
        # Other OS Java <===================================================
    # Other OS <===================================================

    else
      continue
    fi
    # OS Selection <===================================================

else
  continue
fi
# Install Choice <===================================================

clear
echo "Checking the Docker Home git repo for any recent updates."
echo ""
git reset HEAD --hard && git pull
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

# Selection ===================================================>
# 1. Single player RSC game ===================================================>
if [ "$choice" == "1" ]; then
    clear
    echo "You have picked ${GREEN}single player RSC + PHPMyAdmin!${NC}"
    echo ""
    echo ""
    echo "Checking the git repos for any recent updates."
    echo ""
    echo "You may now be prompted for your password so the installer has sudo access."
    echo ""
    cd Game && sudo git reset HEAD --hard && sudo git pull
    cd ..
    sudo chmod -r 777 Game
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
    echo "Fetching the Game from the Open RSC git repo."
    echo ""
    sudo make clone-game
    sudo chmod -r 777 Game
    echo ""
    echo ""
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC
    echo ""
    echo ""
    echo "Importing the databases."
    echo ""
    sudo make import
    echo ""
    echo ""
    echo "Open RSC setup complete!"
    echo ""
    exit
# 1. Single player RSC game <===================================================

# 2. Game + Website + PHPMyAdmin ===================================================>
elif [ "$choice" == "2" ]; then
    clear
    echo "You have picked ${GREEN}Game + Website + PHPMyAdmin!${NC}"
    echo ""
    echo ""
    echo "Checking the git repos for any recent updates."
    echo ""
    echo "You may now be prompted for your password so the installer has sudo access."
    echo ""
    cd Game && sudo git reset HEAD --hard && sudo git pull
    cd ..
    sudo chmod -r 777 Game
    echo ""
    cd Website && sudo git reset HEAD --hard && sudo git pull
    cd ..
    sudo chmod -r 777 Website
    sudo chmod -r 644 Website/board/config.php
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
    sudo chmod -r 777 Game
    echo ""
    sudo make clone-website
    sudo chmod -r 777 Website
    sudo chmod -r 644 Website/board/config.php
    echo ""
    echo ""
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC
    echo ""
    echo ""
    echo "Importing the databases in 15 seconds."
    echo ""
    sudo make import
    echo ""
    echo ""
    echo "Open RSC setup complete!"
    echo ""
    exit
# 2. Game + Website + PHPMyAdmin <===================================================

# 3. Game + Website + PHPMyAdmin + RSC Preservation Wiki ===================================================>
elif [ "$choice" == "3" ]; then
    clear
    echo "You have picked ${GREEN}Game + Website + PHPMyAdmin + RSC Preservation Wiki!${NC}"
    echo ""
    echo ""
    echo "Checking the git repos for any recent updates."
    echo ""
    echo "You may now be prompted for your password so the installer has sudo access."
    echo ""
    cd Game && git sudo reset HEAD --hard && sudo git pull
    cd ..
    sudo chmod -r 777 Game
    echo ""
    cd Website && sudo git reset HEAD --hard && sudo git pull
    cd ..
    sudo chmod -r 777 Website
    sudo chmod -r 644 Website/board/config.php
    echo ""
    cd Website/Wiki && sudo git reset HEAD --hard && sudo git pull
    cd ..
    sudo chmod -r 777 Website/Wiki
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
    sudo chmod -r 777 Game
    echo ""
    sudo make clone-website
    sudo chmod -r 777 Website
    sudo chmod -r 644 Website/board/config.php
    echo ""
    sudo make clone-wiki
    sudo chmod -r 777 Website/Wiki
    echo ""
    echo ""
    echo "Extracting the Wiki database."
    echo ""
    sudo unzip -o Website/Wiki/openrsc_wiki.sql.zip -d Website/Wiki
    echo ""
    echo ""
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC
    echo ""
    echo ""
    echo "Importing the game, forum, and wiki databases."
    echo ""
    sudo make import
    echo ""
    sudo make import-wiki
    echo ""
    echo ""
    echo "Open RSC setup complete!"
    echo ""
    exit
    # 3. Game + Website + PHPMyAdmin + RSC Preservation Wiki <===================================================

else
    echo ""
    echo "Error! ${RED}$choice${NC} is not a valid option. Press enter to try again."
    echo ""
    read
    ./Setup_Linux_Mac.sh
fi
# Selection <===================================================
