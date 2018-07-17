# Open RSC Docker Home
An easy to run RSC private server environment using Docker that works in Windows, Mac, and Linux.

Choices:

  1. Single player RSC game + basic database editing (PHPMyAdmin)
  2. Game + Website + PHPMyAdmin
  3. Game + Website + PHPMyAdmin + RSC Preservation Wiki

___

## Operating systems supported

* Windows 7 x64

* Windows 10 x64

* Mac OS X High Sierra

* Ubuntu Linux 18.04 x64

* Fedora Linux 28 x64

* CentOS 7 x64

___

## Choice 1: Download the zip, extract it, and open the "Docker-Home" folder

https://github.com/Open-RSC/Docker-Home/archive/master.zip

## Choice 2: Clone the project with git

Install [Git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git), then clone the project:

  ```sh
  git clone https://github.com/Open-RSC/Docker-Home.git
  ```

___

## Important for Windows users!

Open Docker and make your drives available to your Docker containers:

![Shared drives setting](https://i.imgur.com/6YsGkoZ.png)

___

## Run the scripts

1. Perform the first time setup:

    ```sh
    Mac/Linux: ./Setup_Linux_Mac.sh
    ```

    ```sh
    Windows: "Setup_Windows.cmd"
    ```

2. Open your favorite browser:

    * [http://localhost](http://localhost/) (username: Marwolf, password: malware)
    * [http://localhost:8080](http://localhost:8080/) PHPMyAdmin (username: root, password: root)
    * [http://localhost/wiki](http://localhost/wiki) (username: Marwolf, password: openrscpassword)

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

___

## Ready to host a public version on your own VPS?

You will need to edit:

* PHPMyAdmin's MySQL users

  * Create a new user in PHPMyAdmin, grant permissions, remove existing users.

  * Secure your users by making them only accessible from specific hostnames

  * Each Docker container will have it's own assigned internal IP address.

  * Examples:

    * openrsc_forum @ 172.18.0.3 (only accessible via Nginx Docker container)

    * openrsc_game @ 172.18.0.1 (only accessible via locally running Open RSC game server)

    * Marwolf @ 172.18.0.4 (only accessible via PHPMyAdmin Docker container)

  * Avoid: % for any host (risks allowing remote brute force MySQL server attacks)

* Launcher's main.java

  * Edit: /Docker-Home/Game/Launcher/src/Main.java

    * Replace with your domain / IP: private static String URL = "http://localhost";

* Client's config.java

  * Edit: /Docker-Home/Game/client/src/org/openrsc/client/Config.java

    * Replace with your domain / IP: public static String IP = "localhost";

* Server's config.xml

  * Edit: /Docker-Home/Game/server/config/config.xml

    * Replace with your newly created SQL username: <entry key="dblogin">root</entry>

    * Replace with your newly created SQL user pass: <entry key="dbpass">root</entry>

* Website's board/config.php

  * Edit: /Docker-Home/Website/board/config.php

    * Replace with your newly created SQL username: $dbuser = 'root';

    * Replace with your newly created SQL user pass: $dbpasswd = 'root';

* Website's client.zip file

  * Compile changes for your client and compress "Open_RSC_Client.jar" as client.zip

    * Location: /Docker-Home/Game/client/dist/Open_RSC_Client.jar

    * Copy result to: /Docker-Home/Website/downloads/client.zip

* Website's downloads/hashes.txt

  * Edit: /Docker-Home/Website/downloads/hashes.txt

    * Replace with updated md5sum hashes of your client.zip and cache.zip (likely you only will replace client.zip)

    * Obtain MD5sum via md5sum *.zip

___
