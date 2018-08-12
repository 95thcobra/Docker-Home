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
    echo "${RED}2${NC} - Fedora 28 Linux"
    echo "${RED}3${NC} - CentOS 7 Linux"
    echo "${RED}4${NC} - Mac OS High Sierra"
    echo "${RED}5${NC} - Other"
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
        echo "Verifying the basics are installed."
        echo ""
        sudo apt update && sudo apt install screen zip fail2ban unzip git build-essential apt-transport-https ca-certificates curl software-properties-common -y
        echo ""
        echo ""
        echo "Do you have Docker installed? It is required for this."
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # Ubuntu Docker ===================================================>
        if [ "$docker" == "1" ]; then
            echo "Attempting to install Docker now"
            echo ""
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $vers stable"
            sudo apt update && sudo apt install docker-ce docker-compose -y
        else
          continue
        fi
        # Ubuntu Docker <===================================================

        echo ""
        echo "Preventing Docker from making the iptables firewall insecure."
        echo ""
        echo '{
    "iptables": false
}' | sudo tee --append  /etc/docker/daemon.json && sudo service docker restart
        echo ""
        echo ""
        echo "Configuring UFW to allow good ports and block MySQL from outside."
        echo ""
        sudo ufw allow 22/tcp && ufw allow 80/tcp && ufw allow 8080/tcp && ufw allow 443/tcp && ufw allow 9000/tcp && ufw allow 53595/tcp && ufw deny 3306/tcp
        sudo sed -i 's/DEFAULT_FORWARD_POLICY="DENY"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
        sudo ufw reload
        echo ""
        echo ""
        echo "UFW firewall rules have been added. Enable it later via:"
        echo "sudo ufw enable"
        echo ""
        echo ""
        echo "Do you have Oracle Java JDK 8 and Gradle installed already? It is required for this."
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # Ubuntu Java ===================================================>
        if [ "$java" == "1" ]; then
            sudo apt-get remove openjdk-6-jre default-jre default-jre-headless -y
            sudo add-apt-repository ppa:webupd8team/java -y && sudo apt update && sudo apt install gradle ant oracle-java8-set-default openjfx -y
        else
          continue
        fi
        # Ubuntu Java <===================================================
    # Ubuntu OS <===================================================

    # Fedora OS ===================================================>
    elif [ "$os" == "2" ]; then
        echo ""
        echo ""
        echo "Verifying the basics are installed."
        echo ""
        sudo dnf -y update && sudo dnf -y upgrade && sudo dnf -y install zip fail2ban screen make unzip git ca-certificates curl yum-utils device-mapper-persistent-data lvm2
        sudo systemctl start fail2ban
        sudo systemctl enable fail2ban
        echo ""
        echo ""
        echo "Permitting good ports through the firewall."
        echo ""
        firewall-cmd --permanent --add-port=53595/tcp
        firewall-cmd --permanent --add-port=8080/tcp
        firewall-cmd --permanent --add-port=9000/tcp
        firewall-cmd --permanent --add-port=80/tcp
        firewall-cmd --permanent --add-port=443/tcp
        firewall-cmd --permanent --add-port=22/tcp
        firewall-cmd --reload
        echo ""
        echo ""
        echo "Do you have Oracle Java JDK 8 and Gradle installed already? It is required for this."
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # Fedora Java ===================================================>
        if [ "$java" == "1" ]; then
            sudo dnf -y install gradle ant openjfx
            wget --no-cookies \
            --no-check-certificate \
            --header "Cookie: oraclelicense=accept-securebackup-cookie" \
            "http://download.oracle.com/otn-pub/java/jdk/8-b132/jdk-8-linux-x64.rpm" \
            -O jdk-8-linux-x64.rpm
            sudo rpm -Uvh jdk-8-linux-x64.rpm
            sudo alternatives --install /usr/bin/java java /usr/java/jdk1.8.0/jre/bin/java 20000
            sudo alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0/bin/jar 20000
            sudo alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0/bin/javac 20000
            sudo alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0/jre/bin/javaws 20000
        else
          continue
        fi
        # Fedora Java <===================================================

        echo ""
        echo ""
        echo "Do you have Docker installed? It is required for this."
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # Fedora Docker ===================================================>
        if [ "$docker" == "1" ]; then
            echo "Removing any old versions of Docker that might confict."
            echo ""
            sudo dnf -y remove docker \
                 docker-client \
                 docker-client-latest \
                 docker-common \
                 docker-latest \
                 docker-latest-logrotate \
                 docker-logrotate \
                 docker-selinux \
                 docker-engine-selinux \
                 docker-engine
            echo ""
            echo ""
            echo "Attempting to install Docker now."
            echo ""
            sudo dnf -y install dnf-plugins-core
            sudo dnf -y config-manager \
              --add-repo \
              https://download.docker.com/linux/fedora/docker-ce.repo
            sudo dnf -y install docker-ce docker-compose
            sudo systemctl start docker
            sudo systemctl enable docker
            sudo usermod -aG docker $USER
        else
          continue
        fi
        # Fedora Docker <===================================================
    # Fedora OS <===================================================

    # CentOS 7 OS ===================================================>
    elif [ "$os" == "3" ]; then
        echo ""
        echo ""
        echo "Verifying the basics are installed."
        echo ""
        sudo wget http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64//dnf-0.6.4-2.sdl7.noarch.rpm
        sudo wget http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/dnf-conf-0.6.4-2.sdl7.noarch.rpm
        sudo wget http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/python-dnf-0.6.4-2.sdl7.noarch.rpm
        sudo yum -y install dnf-0.6.4-2.sdl7.noarch.rpm dnf-conf-0.6.4-2.sdl7.noarch.rpm python-dnf-0.6.4-2.sdl7.noarch.rpm
        sudo dnf -y update && sudo dnf -y upgrade && sudo dnf -y install zip fail2ban screen make unzip git ca-certificates curl yum-utils device-mapper-persistent-data lvm2
        sudo yum install -y python-pip
        sudo pip install --upgrade pip
        sudo pip install docker-compose
        sudo yum upgrade python*
        sudo systemctl start fail2ban
        sudo systemctl enable fail2ban
        echo ""
        echo ""
        echo "Permitting ports through the firewall."
        firewall-cmd --permanent --add-port=53595/tcp
        firewall-cmd --permanent --add-port=8080/tcp
        firewall-cmd --permanent --add-port=9000/tcp
        firewall-cmd --permanent --add-port=443/tcp
        firewall-cmd --permanent --add-port=22/tcp
        firewall-cmd --reload
        echo ""
        echo ""
        echo "Do you have Oracle Java JDK 8 and Gradle installed already? It is required for this."
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # CentOS 7 Java ===================================================>
        if [ "$java" == "1" ]; then
            sudo dnf -y install gradle ant openjfx
            wget --no-cookies \
            --no-check-certificate \
            --header "Cookie: oraclelicense=accept-securebackup-cookie" \
            "http://download.oracle.com/otn-pub/java/jdk/8-b132/jdk-8-linux-x64.rpm" \
            -O jdk-8-linux-x64.rpm
            sudo rpm -Uvh jdk-8-linux-x64.rpm
            sudo alternatives --install /usr/bin/java java /usr/java/jdk1.8.0/jre/bin/java 20000
            sudo alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0/bin/jar 20000
            sudo alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0/bin/javac 20000
            sudo alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0/jre/bin/javaws 20000
        else
          continue
        fi
        # CentOS 7 Java <===================================================

        echo ""
        echo ""
        echo "Do you have Docker installed? It is required for this."
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # CentOS 7 Docker ===================================================>
        if [ "$docker" == "1" ]; then
            echo "Removing any old versions of Docker that might confict."
            echo ""
            sudo dnf -y remove docker \
                 docker-client \
                 docker-client-latest \
                 docker-common \
                 docker-latest \
                 docker-latest-logrotate \
                 docker-logrotate \
                 docker-selinux \
                 docker-engine-selinux \
                 docker-engine
            echo ""
            echo ""
            echo "Attempting to install Docker now."
            echo ""
            curl -fsSL https://get.docker.com/ | sh
            sudo systemctl start docker
            sudo systemctl enable docker
            sudo usermod -aG docker $USER
            sudo dnf -y install docker-compose
        else
          continue
        fi
        # CentOS 7 Docker <===================================================
    # CentOS 7 OS <===================================================

    # Mac OS ===================================================>
    elif [ "$os" == "4" ]; then
        clear
        echo "Do you have brew installed? It is required for this."
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
        echo "Verifying the basics are installed."
        echo ""
        brew install unzip wget git curl zip screen
        echo ""
        echo ""
        echo "Do you have Oracle Java JDK 8 and Gradle installed already? It is required for this."
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # Mac Java ===================================================>
        if [ "$java" == "1" ]; then
            brew tap AdoptOpenJDK/openjdk
            brew install adoptopenjdk-openjdk8 gradle ant openjfx
        fi
        # Mac Java <===================================================

        echo ""
        echo ""
        echo "Do you have Docker installed? It is required for this."
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # Mac Docker ===================================================>
        if [ "$docker" == "1" ]; then
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
    elif [ "$os" == "5" ]; then
        echo ""
        echo "You will have to install Git manually then. Press enter to continue."
        echo ""
        read
        echo ""
        echo "Do you have Docker installed? It is required for this."
        echo ""
        echo "${RED}1${NC} - No, install it for me!"
        echo "${RED}2${NC} - Yes"
        echo ""
        read docker

        # Other OS Docker ===================================================>
        if [ "$docker" == "1" ]; then
            echo "Attempting to install Docker now. If it fails, install manually."
            echo ""
            curl -fsSL get.docker.com -o get-docker.sh
            sudo sh get-docker.sh
        else
          continue
        fi
        # Other OS Docker <===================================================

        echo ""
        echo ""
        echo "Do you have Oracle Java JDK 8 and Gradle installed already? It is required for this. If it fails, install manually."
        echo ""
        echo "${RED}1${NC} - Install for me!"
        echo "${RED}2${NC} - Im all set"
        echo ""
        read java

        # Other OS Java ===================================================>
        if [ "$java" == "1" ]; then
            sudo apt-get remove openjdk-6-jre default-jre default-jre-headless -y
            sudo add-apt-repository ppa:webupd8team/java -y && sudo apt update && sudo apt install gradle ant oracle-java8-set-default openjfx -y
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
echo "Checking for updates to the Docker-Home repository."
echo ""
sudo git pull
echo ""
echo ""
echo ""
echo "${RED}Open RSC Installer:${NC}
An easy to run RSC private server using Docker magic.

Choices:
  ${RED}1${NC} - Set up for single player
  ${RED}2${NC} - Deployment for a publicly hosted server"
echo "

Which of the above do you want? Type 1, 2, or 3, and press enter."
echo ""
read choice

# Selection ===================================================>
# 1. Single player RSC game ===================================================>
if [ "$choice" == "1" ]; then
    clear
    echo "You have picked ${GREEN}Set up for single player!${NC}"
    echo ""
    echo ""
    echo "Starting up the Docker containers and stopping any existing ones."
    echo ""
    sudo make stop
    echo ""
    sudo make start-single-player
    echo ""
    echo ""
    echo "Fetching the Game from the Open RSC git repo."
    echo ""
    sudo make clone-game
    sudo chmod -R 777 Game
    echo ""
    echo ""
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC
    echo ""
    echo ""
    echo "Importing the game databases."
    echo ""
    sudo make import-game
    echo ""
    echo ""
    echo "Open RSC setup complete!"
    echo ""
    exit
# 1. Single player RSC game <===================================================

# 2. Game + Website + PHPMyAdmin ===================================================>
elif [ "$choice" == "2" ]; then
    clear
    echo "You have picked ${GREEN}Deployment for a publicly hosted server!${NC}"
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
    echo "Creating the client cache in your home folder."
    echo ""
    mkdir ~/OpenRSC
    unzip -o Game/client/cache.zip -d ~/OpenRSC
    echo ""
    echo ""
    echo "Importing the game databases."
    echo ""
    sudo make import-game
    echo ""
    echo ""
    echo "Open RSC setup complete!"
    echo ""
    exit
# 2. Game + Website + PHPMyAdmin <===================================================

else
    echo ""
    echo "Error! ${RED}$choice${NC} is not a valid option. Press enter to try again."
    echo ""
    read
    ./Setup_Linux_Mac.sh
fi
# Selection <===================================================
