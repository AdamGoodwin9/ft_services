FROM alpine

RUN apk update && apk add --no-cache vsftpd openssl

RUN mkdir -p /etc/ftps/agoodwin && adduser --home=/etc/ftps/agoodwin -D agoodwin && echo "agoodwin:1234" | chpasswd

COPY vsftpd.conf /etc/vsftpd/

RUN echo "agoodwin" >> /etc/vsftpd/vsftpd.userlist

RUN openssl req -new -newkey rsa:2048 -nodes -days 365 -x509 \
	-subj "/C=US/ST=California/L=Los Angeles/O=Ecole 42/OU=Students/CN=localhost" \
	-keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && mkdir -p /etc/telegraf

COPY telegraf.conf /etc/telegraf/

EXPOSE 21 21000

COPY setup.sh ./

CMD ./setup.sh
