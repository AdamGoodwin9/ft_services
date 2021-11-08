FROM alpine

COPY init_file wordpress.sql my.cnf ./

RUN apk update && apk add --no-cache mysql mysql-client

RUN mkdir -p /run/mysqld

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && mkdir -p /etc/telegraf

COPY telegraf.conf /etc/telegraf/

COPY my.cnf /etc/

EXPOSE 3306

COPY setup.sh ./

CMD ./setup.sh