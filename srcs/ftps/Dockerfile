FROM alpine

COPY vsftpd.conf telegraf.conf setup.sh ./

RUN apk update && \
	apk add --no-cache vsftpd openssl

RUN mkdir -p /etc/ftps/agoodwin && \
	adduser --home=/etc/ftps/agoodwin -D agoodwin && \
	echo "agoodwin:1234" | chpasswd

RUN mv vsftpd.conf /etc/vsftpd/ && \
	echo "agoodwin" >> /etc/vsftpd/vsftpd.userlist

RUN openssl req -new -newkey rsa:2048 -nodes -days 365 -x509 \
	-subj "/C=US/ST=California/L=Los Angeles/O=Ecole 42/OU=Students/CN=localhost" \
	-keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 20 21 21009-21011

CMD ./setup.sh