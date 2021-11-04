/usr/bin/telegraf &

/usr/sbin/influxd & sleep 3

influx -execute "CREATE DATABASE grafana"
influx -execute "CREATE USER agoodwin WITH PASSWORD '1234'"
influx -execute "GRANT ALL ON grafana TO agoodwin"

tail -f /dev/null