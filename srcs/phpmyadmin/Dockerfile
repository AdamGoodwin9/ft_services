FROM alpine

RUN apk update && apk add --no-cache php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session nginx php7-fpm

ADD https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz .

RUN tar -xvf phpMyAdmin-5.0.2-english.tar.gz && mv phpMyAdmin-5.0.2-english /www && \
	rm -f phpMyAdmin-5.0.2-english.tar.gz

COPY config.inc.php /www/

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && mkdir -p /etc/telegraf

COPY telegraf.conf /etc/telegraf/

COPY default.conf /etc/nginx/http.d/default.conf

EXPOSE 5000

COPY setup.sh ./

CMD ./setup.sh