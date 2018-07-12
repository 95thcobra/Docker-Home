# Open RSC Docker Home
An easy to run RSC private server environment using Docker.

___

## Install prerequisites

This is compatible with `(Windows, Ubuntu Linux, and macOS)`.

Prerequisites:

* [Git](https://git-scm.com/downloads)
* [Docker](https://docs.docker.com/engine/installation/)

If your running Ubuntu 18.04, execute the following script and skip the rest of this section:

  ```sh
  ./install-docker-linux.sh
  ```

To manually set up the prerequisites in Ubuntu 18.04 (bionic) Linux (modify where it reads "bionic" below as needed for your Ubuntu distro):

  ```sh
  sudo apt update && install build-essential apt-transport-https ca-certificates curl software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  sudo apt update && install docker-ce docker-compose -y
  ```
___

## Choice 1 (easy): Download the project zip, extract it, and open the "Docker-Home" folder

https://github.com/Open-RSC/Docker-Home/archive/master.zip

## Choice 2 (advanced): Clone the project with git

Install [Git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git), then clone the project:

  ```sh
  git clone https://github.com/Open-RSC/Docker-Home.git
  ```

Go to the project directory:

  ```sh
  cd Docker-Home
  ```

___

## Important for Windows users!

Open Docker and make your drives available to your Docker containers:

![Shared drives setting](https://i.imgur.com/6YsGkoZ.png)

___

## Run the scripts

1. Perform first time setup and start the Docker application:

    ```sh
    macOS/Ubuntu: ./first-time-setup-linux.sh
    ```

    ```sh
    Windows: "First Time Setup.cmd"
    ```

    **Please wait this might take a several minutes...**

2. Open your favorite browser:

    * [http://localhost](http://localhost/)
    * [http://localhost:8080](http://localhost:8080/) PHPMyAdmin (username: root, password: root)


3. Start the game's Docker containers, then run the game server and client:

    ```sh
    macOS/Ubuntu: ./start-game-linux.sh
    ```

    ```sh
    Windows: "Start Game.cmd"
    ```

4. Backup game databases:

    ```sh
    macOS/Ubuntu: ./backup-game-databases-linux.sh
    ```

    ```sh
    Windows: "Backup Game Databases.cmd"
    ```

5. Restore game databases:

    ```sh
    macOS/Ubuntu: ./restore-game-databases-linux.sh
    ```

    ```sh
    Windows: "Restore Game Databases.cmd"
    ```

6. Stop the game's Docker containers and shut down the game server:

    ```sh
    macOS/Ubuntu: ./stop-game-linux.sh
    ```

    ```sh
    Windows: "Stop Game.cmd"
    ```

7. View the game's Docker container logs:

    ```sh
    ./view-docker-container-logs-linux.sh
    ```

    ```sh
    Windows: "View Docker Container Logs.cmd"
    ```

___
