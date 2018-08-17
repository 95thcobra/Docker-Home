# Open RSC Docker Home [![Build Status](https://travis-ci.org/Open-RSC/Docker-Home.svg?branch=master)](https://travis-ci.org/Open-RSC/Docker-Home)

![Death](https://i.imgur.com/tzLgEwV.png)

# Table of contents <a name="top"></a>
1. [Project Introduction](#introduction)
1. [Default Credentials](#credentials)
2. [Minimum Requirements](#requirements)
3. [How to Obtain Open RSC](#obtain)
4. [Required Step For Windows Users](#windows)
5. [Setup Process](#setup)
6. [Steps to Host on a VPS](#vps)
7. [Remote JMX Sampling](#jmx)


## Project Introduction <a name="introduction"></a>

Choices:

  1. Single player RSC game + basic database editing (PHPMyAdmin)
  2. Game + Website + PHPMyAdmin

The game client registers new players upon their first login attempt.

Admin role is group_id = 1, players are group_id = 10

[Return to top](#top)
___

## Default Credentials <a name="credentials"></a>

#### Website

Username: admin@openrsc.com

Password: malwareinfection


#### Database

Username: root

Password: root

[Return to top](#top)
___

## Minimum Requirements (suggested use a VPS host or a VirtualBox VM) <a name="requirements"></a>

* Windows 10 (sorry, no Windows 7 due to Docker for Windows incompatibility)

* Mac OS X High Sierra

* Ubuntu Linux 16.04 and above (or a derivative like Mint Linux)

* Fedora Linux 28

* CentOS 7 x64

[Return to top](#top)
___

## How to Obtain Open RSC <a name="obtain"></a>

#### Option 1: Download the zip, extract it, and open the "Docker-Home" folder

https://github.com/Open-RSC/Docker-Home/archive/master.zip

#### Option 2: Clone the project with git

Install [Git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git), then clone the project:

  ```sh
  git clone https://github.com/Open-RSC/Docker-Home.git
  ```

[Return to top](#top)
___

## Required Step For Windows Users <a name="windows"></a>

Open Docker and make your drives available to your Docker containers:

![Shared drives setting](https://i.imgur.com/6YsGkoZ.png)

[Return to top](#top)
___

## Setup Process <a name="setup"></a>

1. Perform the first time setup:

    ```sh
    Mac/Linux: ./Setup_Linux_Mac.sh
    ```

    ```sh
    Windows: "Setup_Windows.cmd"
    ```

2. Open your favorite browser:

    * [http://localhost](http://localhost)
    * [http://localhost:9000](http://localhost:9000) PHPMyAdmin (default username: root, password: root)
    * [http://localhost:8080](http://localhost:8080) Apache Tomcat webserver, used to serve files over HTTP

3. Start the game's Docker containers, then run the game server and client:

    ```sh
    Mac/Linux: ./Start_Single_Player_Game_Linux_Mac.sh
    ```

    ```sh
    Windows: "Start_Single_Player_Game_Windows.cmd"
    ```

4. Backup game databases:

    ```sh
    Mac/Linux: ./Backup_Game_Databases_Linux_Mac.sh
    ```

    ```sh
    Windows: "Backup_Game_Databases_Windows.cmd"
    ```

5. Restore game databases:

    ```sh
    Mac/Linux: ./Restore_Game_Database_Backup_Linux_Mac.sh
    ```

    ```sh
    Windows: "Restore_Game_Database_Backup_Windows.cmd"
    ```

6. Stop the game's Docker containers and shut down the game server:

    ```sh
    Mac/Linux: ./Stop-Game-Linux_Mac.sh
    ```

    ```sh
    Windows: "Stop_Game_Windows.cmd"
    ```

[Return to top](#top)
___

## Steps to Host on a VPS <a name="vps"></a>

  * Execute "Linux_Installer.sh"

  * Follow the steps to install needed programs

  * Select "2. Deployment for a publicly hosted server"

  * You will be prompted to edit specific files. Below is what to do each:

PHPMyAdmin MariaDB SQL users

  * Create a new user in PHPMyAdmin (http://localhost:9000), grant it all permissions, remove pre-existing users.

    * Use % for the host associated with the new user. Docker containers do not have static IP addresses and we are using the PHPMyAdmin Docker container to connect to the MariaDB Docker container. Each has a unique internally assigned IP address that is not localhost. The Docker container port of tcp/3306 for MariaDB is bound to the server as localhost so there should be no threat of external connections.

"Docker-Home/.env"

  * The main website is running through Ghost CMS. For the section starting with # Ghost:

  * Replace: "URL=http://localhost"

  * Nginx has a hostname reference for localhost as "NGINX_HOST=localhost" under the # Nginx section. It can be safely left alone at this time.

  * For the section starting with # MySQL:

    * Set the username and password that have been granted root privileges in MariaDB SQL that you just created in the previous step with PHPMyAdmin where it reads "MYSQL_ROOT_USER=root" and "MYSQL_ROOT_PASSWORD=root"

"Docker-Home/Game/server/config/config.xml"

  * Replace with your newly created SQL username: <entry key="dblogin">root</entry>

  * Replace with your newly created SQL user pass: <entry key="dbpass">root</entry>

"Docker-Home/Game/Launcher/src/Main.java"

  * Replace with your server's IP/domian: private static String Domain = "localhost";

  * Do as you wish for the other lines around it.

"Docker-Home/Game/client/src/org/openrsc/client/Config.java"

  * Replace with your server's IP/domain: public static String IP = "127.0.0.1";

### Website config import:

  * Visit http://localhost/ghost

  * Click on "Labs" once registered / logged in

  * Click "Browse" beside "Import content" and select "/Docker-Home/website_backup.json"

#### Linux_Fetch_Updates_Production.sh

  * Prompts the user to edit files potentially changed since "Linux_Installer.sh" was last ran

  * Compiles client, launcher, and server.

  * Copies "Docker-Home/Game/client/cache.zip" to "Docker-Home/Website/downloads/cache.zip"

  * Copies "Docker-Home/Game/Launcher/Open_RSC_Launcher.jar" to "Docker-Home/Website/downloads/Open_RSC_Launcher.jar"

  * Compresses then copies "Docker-Home/Game/client/client.zip" to "Docker-Home/Website/downloads/client.zip"

  * Md5sums client.zip and cache.zip in "Docker-Home/Website/" and outputs to hashes.txt

  * Starts the game server in a detached screen console. Access via "screen -r", return via "Ctrl + A + D", exit via "Ctrl + C" (executes Linux_Run_Production_Server.sh)

#### Linux_Run_Production_Server.sh

  * Starts the game server in a detached screen console. Access via "screen -r", return via "Ctrl + A + D", exit via "Ctrl + C" (executes "Docker-Home/Game/server/run_server.sh")

#### Docker-Home/Game/server/run_server.sh

  * Kills existing java jar processes (used during server auto restart)

  * Launches "Docker-Home/Game/server/ant_launcher.sh"

#### Docker-Home/Game/server/ant_launcher.sh

  * Starts the game server in a detached screen console. Access via "screen -r", return via "Ctrl + A + D", exit via "Ctrl + C"

[Return to top](#top)
___

## Remote JMX Sampling <a name="jmx"></a>

If hosting externally on a VPS, it is possible to monitor the game server via JMX sampling with VisualVM.

 * ssh -l USERNAME VPS_DOMAIN -L 9990:localhost:9990

 * Open Visual VM and under "Local", right click and select "Add JMX Connection"

 * In "Connection", specify "localhost:9990" and click "OK"

 * Right click where it reads "localhost:9990 (pid xxxx)" and select "Sample"

 [Return to top](#top)
