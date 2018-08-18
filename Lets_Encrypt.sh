#!/bin/bash

sudo docker run -it --rm --name certbot \
        -v `pwd`/etc/letsencrypt/certs:/opt/bitnami/nginx/conf/bitnami/certs \
        deliverous/certbot \
        certonly \
        --webroot --webroot-path=/data/letsencrypt \
        -d localhost -d www.localhost --staging
