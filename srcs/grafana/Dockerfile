FROM alpine

COPY setup.sh telegraf.conf grafana.db ./

RUN apk update && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ grafana

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && \
	mkdir -p /etc/telegraf && \
	mkdir -p /usr/share/grafana/data && \
	mv telegraf.conf /etc/telegraf/ && \
	mv grafana.db /usr/share/grafana/data/

EXPOSE 3000

CMD ./setup.sh