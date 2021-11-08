FROM alpine

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /run/nginx www

COPY index.html /www/

COPY nginx.conf /etc/nginx/

RUN openssl req -new -newkey rsa:2048 -nodes -days 365 -x509 \
	-subj "/C=US/ST=California/L=Los Angeles/O=Ecole 42/OU=Students/CN=localhost" \
	-keyout /etc/ssl/private/services.key -out /etc/ssl/certs/services.crt

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && mkdir -p /etc/telegraf

COPY telegraf.conf /etc/telegraf/

EXPOSE 80 443

COPY setup.sh ./

CMD ./setup.sh