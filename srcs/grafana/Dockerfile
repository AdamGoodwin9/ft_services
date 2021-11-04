FROM alpine:latest

COPY datasource.yaml dashboard.yaml dashboards telegraf.conf setup.sh ./

RUN apk update && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ grafana

RUN mv datasource.yaml /usr/share/grafana/conf/provisioning/datasources/ && \
	mv *.json dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 3000

CMD ./setup.sh