#!/bin/bash

sudo docker run -it --rm --name certbot \
        -v `pwd`/etc/letsencrypt/certs:/etc/letsencrypt \
        -v `pwd`/etc/letsencrypt/data:/data/letsencrypt \
        deliverous/certbot \
        certonly \
        --webroot --webroot-path=/data/letsencrypt \
        -d openrsc.com -d www.openrsc.com --staging
