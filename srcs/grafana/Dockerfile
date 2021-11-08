FROM alpine

RUN apk update && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ grafana

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && \
	mkdir -p /etc/telegraf && mkdir -p /usr/share/grafana/data

COPY telegraf.conf /etc/telegraf/

COPY grafana.db /usr/share/grafana/data/

EXPOSE 3000

<<<<<<< Updated upstream
COPY setup.sh ./

CMD ./setup.sh
=======
CMD ./setup.sh
>>>>>>> Stashed changes
