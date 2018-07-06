## Overview

1. [Install prerequisites](#install-prerequisites)

2. [Clone the project](#clone-the-project)

3. [Run the application](#run-the-application)

___

## Install prerequisites

This project has been created for `(Linux/MacOS)`.

All requisites should be available for your distribution. The most important are :

* [Git](https://git-scm.com/downloads)
* [Docker](https://docs.docker.com/engine/installation/)
* [Docker Compose](https://docs.docker.com/compose/install/)

Check if `docker-compose` is already installed by entering the following command :

```sh
which docker-compose
```

On Ubuntu and Debian these are available in the meta-package build-essential. On other distributions, you may need to install the GNU C++ compiler separately.

```sh
sudo apt install build-essential
```

This project use the following ports :

| Server     | Port |
|------------|------|
| MySQL      | 3306 |
| PHPMyAdmin | 8080 |
| Nginx      | 80   |

___

## Clone the project

To install [Git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git), download it and install following the instructions :

```sh
git clone https://github.com/nanoninja/docker-nginx-php-mysql.git
```

Go to the project directory :

```sh
cd docker-nginx-php-mysql
```


___

## Configure Nginx With SSL Certificates

You can change the host name by editing the `.env` file.

If you modify the host name, do not forget to add it to the `/etc/hosts` file.

1. Configure Nginx

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

___

## Run the application

1. Start the Docker application :

    ```sh
    sudo make start
    ```

    **Please wait this might take a several minutes...**

    ```sh
    sudo make logs # Follow log output
    ```

2. Clone the required git repositories:

    ```sh
    sudo make clone
    ```

3. Import the required databases:

    ```sh
    sudo make import
    ```

4. Open your favorite browser :

    * [http://localhost](http://localhost/)
    * [http://localhost:8080](http://localhost:8080/) PHPMyAdmin (username: root, password: root)

5. Backup your databases:

    ```sh
    sudo make backup
    ```

6. Restore your databases:

    ```sh
    sudo make restore
    ```

7. Get help:

    ```sh
    sudo make help
    ```

8. Stop the application:

    ```sh
    sudo make stop
    ```

___

## Additional commands

| Name          | Description                                  |
|---------------|----------------------------------------------|
| clone         | Clone the git repository folders             |
| pull          | Get the latest git repository updates        |
| start         | Create and start containers                  |
| stop          | Stop all containers                          |
| restart       | Restart all containers                       |
| logs          | Display log output                           |
| import        | Import all databases from git repositories   |
| backup        | Create backup of all local databases         |
| restore       | Restore backup of all local databases        |
| flush         | Delete local git repository folders          |
