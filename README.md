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


## Project Introduction <a name="introduction"></a>

Choices:

  1. Single player RSC game + basic database editing (PHPMyAdmin)
  2. Game + Website + PHPMyAdmin

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

* Ubuntu Linux 18.04 (or a derivative like Mint Linux)

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

    * [http://localhost](http://localhost) (username: Marwolf, password: malware)
    * [http://localhost:9000](http://localhost:9000) PHPMyAdmin (username: root, password: root)
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
6. View the game's Docker container logs:

    ```sh
    ./View_Docker_Container_Logs_Linux_Mac.sh
    ```

    ```sh
    Windows: "View_Docker_Container_Logs_Windows.cmd"
    ```

7. Stop the game's Docker containers and shut down the game server:

    ```sh
    Mac/Linux: ./Stop-Game-Linux_Mac.sh
    ```

    ```sh
    Windows: "Stop_Game_Windows.cmd"
    ```

[Return to top](#top)
___

## Steps to Host on a VPS <a name="vps"></a>

You will need to edit:

#### Docker-Compose.xml Ghost URL

  * The main website is running through Ghost Blog. Scroll to the bottom of Docker-Compose.xml (located in the root of the Docker-Home repository folder) and edit this line with your hostname / IP: "url: 'http://localhost' #change this!"

  * You will need to reload all docker containers. Shortcut command: "sudo make stop && sudo make start"

  * Nginx has a hostname reference for localhost at the top of the file. It can be safely left alone.


#### PHPMyAdmin MariaDB SQL users

  * Create a new user in PHPMyAdmin, grant permissions, remove existing users.

  * Use % for the host associated with the user. Docker containers get fresh IPs, the setup script configures firewall to block external access to MariaDB and the Docker container for MariaDB is bound to localhost.

#### Launcher main.java

  * Edit: "/Docker-Home/Game/Launcher/src/Main.java"

    * Replace with your domain / IP: "private static String Domain = "localhost";"

  * Compile and copy result from "/Docker-Home/Game/Launcher/dist/Open_RSC_Launcher.jar" to "/Docker-Home/Website/downloads/Open_RSC_Launcher.jar"

#### Client config.java

  * Edit: "/Docker-Home/Game/client/src/org/openrsc/client/Config.java"

    * Replace with your domain / IP: public static String IP = "localhost";

    * Compile and compress "/Docker-Home/Game/Launcher/dist/Open_RSC_Launcher.jar" as "/Docker-Home/Game/Launcher/dist/client.zip" then copy "/Docker-Home/Game/Launcher/dist/client.zip" to "/Docker-Home/Website/downloads/client.zip"

#### Server config.xml

  * Edit: /Docker-Home/Game/server/config/config.xml

    * Replace with your newly created SQL username: <entry key="dblogin">root</entry>

    * Replace with your newly created SQL user pass: <entry key="dbpass">root</entry>

#### Website downloads/hashes.txt

  * Edit: /Docker-Home/Website/downloads/hashes.txt

    * Replace with updated md5sum hashes of client.zip and cache.zip (likely you only will replace client.zip's hash)

    * Obtain MD5sum via command: "md5sum *.zip"

### Website config import:

  * Visit http://localhost/ghost

  * Login with admin@openrsc.com / malwareinfection

  * Click on "Labs"

  * Click "Browse" beside "Import content" and select ""/Docker-Home/website_backup.json"

[Return to top](#top)
