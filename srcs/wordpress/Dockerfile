FROM alpine

RUN apk update && apk add --no-cache php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session nginx php7-fpm

ADD https://wordpress.org/latest.tar.gz .

RUN tar -xvf latest.tar.gz && mv wordpress /www && rm -f latest.tar.gz

COPY wp-config.php /www/

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && mkdir -p /etc/telegraf

COPY telegraf.conf /etc/telegraf/

COPY default.conf /etc/nginx/http.d/default.conf

EXPOSE 5050

COPY setup.sh ./

CMD ./setup.sh