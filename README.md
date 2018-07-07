## Overview

1. [Install prerequisites](#install-prerequisites)

2. [Clone the project](#clone-the-project)

3. [Run the application](#run-the-application)

___

## Install prerequisites

This project has been created for `(Linux/MacOS)`.

Requisites:

* [Git](https://git-scm.com/downloads)
* [Docker](https://docs.docker.com/engine/installation/)
* [Docker Compose](https://docs.docker.com/compose/install/)

Check if `docker-compose` is already installed by entering the following command:

```sh
which docker-compose
```

On Ubuntu and Debian these are available in the meta-package build-essential. On other distributions, you may need to install the GNU C++ compiler separately.

```sh
sudo apt install build-essential
```

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

## Run the application

1. Perform first time setup and start the Docker application:

    ```sh
    ./first-time-setup.sh
    ```

    **Please wait this might take a several minutes...**

2. Open your favorite browser:

    * [http://localhost](http://localhost/)
    * [http://localhost:8080](http://localhost:8080/) PHPMyAdmin (username: root, password: root)

3. Backup your databases:

    ```sh
    ./backup-database.sh
    ```

4. Restore your databases:

    ```sh
    ./restore-database.sh
    ```

5. Get help:

    ```sh
    sudo make help
    ```

6. Stop the application:

    ```sh
    ./stop.sh
    ```

7. Start the application:

    ```sh
    ./start.sh
    ```

8. Restart the application:

    ```sh
    ./restart.sh
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
