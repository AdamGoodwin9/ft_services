FROM alpine

RUN apk update && apk add --no-cache influxdb

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && mkdir -p /etc/telegraf && \

COPY telegraf.conf /etc/telegraf/

EXPOSE 8086

COPY setup.sh ./

CMD ./setup.sh