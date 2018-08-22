# Open RSC Docker Home [![Build Status](https://travis-ci.org/Open-RSC/Docker-Home.svg?branch=master)](https://travis-ci.org/Open-RSC/Docker-Home)

![Death](https://i.imgur.com/tzLgEwV.png)

# Table of contents <a name="top"></a>
1. [How to Install](#install)
2. [Choices](#choices)
3. [Default Credentials](#credentials)
4. [Minimum Requirements](#requirements)
5. [Required Step For Windows Users](#windows)
6. [Setup Process](#setup)
7. [Steps to Host on a VPS](#vps)


## How to Install Open RSC <a name="install"></a>

Install with this command (from your Linux machine):

    ```sh
    curl -sSL https://raw.githubusercontent.com/Open-RSC/Docker-Home/master/Linux_Installer.sh | bash
    ```

[Return to top](#top)
___

## Choices <a name="choices"></a>

  1. Single player RSC game + basic database editing (PHPMyAdmin)
  2. Game + Website + PHPMyAdmin

The game client registers new players upon their first login attempt.

Admin role is group_id = 1, players are group_id = 10

[Return to top](#top)
___

## Default Credentials <a name="credentials"></a>

#### Ghost CMS Website

Username: admin@openrsc.com

Password: malwareinfection


#### Database

Username: root

Password: root

[Return to top](#top)
___

## Minimum Requirements <a name="requirements"></a>

* Windows 10

* Mac OS X High Sierra

* Ubuntu Linux 18.04

* Other Linux (no support provided)

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
    Mac/Linux: ./Linux_Installer.sh
    ```

    ```sh
    Windows: "Windows_Installer.cmd"
    ```

2. Open your favorite browser:

    * [http://localhost](http://localhost)
    * [http://localhost:9000](http://localhost:9000) PHPMyAdmin (default username: root, password: root)
    * [http://localhost:8080](http://localhost:8080) Apache Tomcat webserver

3. Start the Docker containers and run the game server and client:

    ```sh
    Mac/Linux: ./Linux_Single_Player.sh
    ```

    ```sh
    Windows: "Windows_Single_Player.cmd"
    ```

4. Backup all databases:

    ```sh
    Mac/Linux: ./Linux_Backup_Databases.sh
    ```

    ```sh
    Windows: "Windows_Backup_Databases.cmd"
    ```

6. Stop the game's Docker containers and shut down the game server:

    ```sh
    Mac/Linux: sudo make stop
    ```

    ```sh
    Windows: "Windows_Stop_Game_Server.cmd"
    ```

[Return to top](#top)
___

## Steps to Host on a VPS <a name="vps"></a>

  * Run the installer:

  ```sh
  curl -sSL https://raw.githubusercontent.com/Open-RSC/Docker-Home/master/Linux_Installer.sh | bash
  ```

  * Follow the steps to install needed programs

  * Select "2. Deployment for a publicly hosted server"

  * You will be prompted to edit specific files. Below is what to do each:

PHPMyAdmin MariaDB SQL users

  * Create a new user in PHPMyAdmin (http://localhost:9000), grant it all permissions, remove pre-existing users.

    * Use % for the host associated with the new user. Docker containers do not have static IP addresses and we are using the PHPMyAdmin Docker container to connect to the MariaDB Docker container. Each has a unique internally assigned IP address that is not localhost. The Docker container port of tcp/3306 for MariaDB is bound to the server as localhost so there should be no threat of external connections.

"Docker-Home/.env"

  * The main website is running through Ghost CMS. For the section starting with # Ghost:

  * Replace: "URL=http://localhost/blog"

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

  * Visit http://localhost/blog/ghost

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

[Return to top](#top)
