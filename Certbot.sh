sudo certbot certonly \
--standalone \
--preferred-challenges http \
--agree-tos -n \
--config-dir ./etc/letsencrypt \
-d wolfkingdom.net \
-m cleako@gmail.com \
-q
