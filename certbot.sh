#!/bin/bash

sudo docker run -it --rm --name certbot \
        -v `pwd`/etc/certbot/certs:/etc/letsencrypt \
        -v `pwd`/etc/certbot/data:/data/letsencrypt \
        deliverous/certbot \
        certonly \
        --webroot --webroot-path=/data/letsencrypt \
        -d openrsc.com -d www.openrsc.com --staging
