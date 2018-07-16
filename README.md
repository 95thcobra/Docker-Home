# Open RSC Docker Home
An easy to run RSC private server environment using Docker that works in Windows, Mac, and Linux.

Choices:

  1. Single player RSC game + basic database editing (PHPMyAdmin)
  2. Game + Website + PHPMyAdmin
  3. Game + Website + PHPMyAdmin + RSC Preservation Wiki


Operating systems supported:

* Windows 10 x64

* Mac OS X High Sierra

* Ubuntu Linux 18.04 x64

* Fedora Linux 28 x64

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
