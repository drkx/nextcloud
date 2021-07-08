FROM nextcloud:fpm-alpine
ENV PHP_MEMORY_LIMIT=1G
ENV PHP_UPLOAD_MAX_FILESIZE=100M
RUN apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing dlib
RUN apk add openblas-dev lapack-dev samba-client bzip2-dev
RUN wget https://github.com/goodspb/pdlib/archive/master.zip \
  && mkdir -p /usr/src/php/ext/ \
  && unzip -d /usr/src/php/ext/ master.zip \
  && rm master.zip
RUN docker-php-ext-install pdlib-master
RUN docker-php-ext-install bz2
RUN echo '*/30 * * * * php -f /var/www/html/occ face:background_job -t 900' >> /var/spool/cron/crontabs/www-data
