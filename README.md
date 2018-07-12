## Overview

1. [Install prerequisites](#install-prerequisites)

2. [Clone the project](#clone-the-project)

3. [Run the application](#run-the-application)

___

## Install prerequisites

This project has been created for `(Windows, Linux, and OS X)`.

Requisites:

* [Git](https://git-scm.com/downloads)
* [Docker](https://docs.docker.com/engine/installation/)
* [A DockerHub Account](https://hub.docker.com/) 

[Guide for installing Docker on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)

___

This project uses the following ports:

| Server                 | Port  |
|------------------------|-------|
| MySQL database server  | 3306  |
| PHPMyAdmin             | 8080  |
| Nginx web server       | 80    |

___

## Clone the project

Install [Git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git), then clone the project:

  ```sh
  git clone https://github.com/Marwolf/Open-RSC-Docker.git
  ```

Go to the project directory:

  ```sh
  cd Open-RSC-Docker
  ```

___

## Important!

If you are using Windows, open Docker and make your drives available to your Docker containers:

![Shared drives setting](https://i.imgur.com/6YsGkoZ.png)

If you are using Linux (suggested to be Ubuntu 18.04 or above), install the build essentials AND docker-compose so that the make command works:

    ```sh
    sudo apt install build-essential docker-compose
    ```

___

## Run the application

1. Perform first time setup and start the Docker application:

    ```sh
    OS X/Linux: ./first-time-setup.sh
    ```

    ```sh
    Windows: "First time setup.cmd"
    ```

    **Please wait this might take a several minutes...**

2. Open your favorite browser:

    * [http://localhost](http://localhost/)
    * [http://localhost:8080](http://localhost:8080/) PHPMyAdmin (username: root, password: root)

3. Backup your databases:

    ```sh
    OS X/Linux: ./backup-database.sh
    ```

    ```sh
    Windows: "Backup Databases.cmd"
    ```

4. Restore your databases:

    ```sh
    OS X/Linux: ./restore-database.sh
    ```

    ```sh
    Windows: "Restore Databases.cmd"
    ```

5. Stop the application:

    ```sh
    OS X/Linux: ./stop.sh
    ```

    ```sh
    Windows: "Stop Containers.cmd"
    ```

6. Start the application:

    ```sh
    OS X/Linux: ./start.sh
    ```

    ```sh
    Windows: "Start Containers.cmd"
    ```

7. Restart the application:

    ```sh
    ./restart.sh
    ```

    ```sh
    Windows: "Restart Containers.cmd"
    ```

8. View container logs:

```sh
./view-logs.sh
```

```sh
Windows: "View Container Logs.cmd"
```

9. Pull repository updates:

```sh
./pull-updates.sh
```

```sh
Windows: "Pull Repository Updates.cmd"
```

___

## Additional commands for troubleshooting use

| Name          | Description                                   |
|---------------|-----------------------------------------------|
| first         | Perform first time setup                      |
| clone         | Clone the git repository folders              |
| pull          | Get the latest git repository updates         |
| start         | Create and start containers                   |
| stop          | Stop all containers                           |
| restart       | Restart all containers                        |
| logs          | Display log output                            |
| import        | Import all databases from git repositories    |
| backup        | Create backup of all local databases          |
| restore       | Restore backup of all local databases         |
| flush         | Delete local git repository folders           |

___

## Optional: configure Nginx With SSL Certificates

You can change the host name by editing the `.env` file.

If you modify the host name, do not forget to add it to the `/etc/hosts` file.

1. Configure Nginx:

    Do not modify the `Website/etc/nginx/default.conf` file, it is overwritten by  `Website/etc/nginx/default.template.conf`

    Edit nginx file `Website/etc/nginx/default.template.conf` and uncomment the SSL server section :

    ```sh
    # server {
    #     server_name ${NGINX_HOST};
    #
    #     listen 443 ssl;
    #     fastcgi_param HTTPS on;
    #     ...
    # }
    ```
2. Copy your server.pem and server.key files in to the `Website/etc/nginx/ssl` folder and restart the application. ([Lets Encrypt](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04) can register SSL certs for free)

    ```sh
    sudo make restart
    ```
