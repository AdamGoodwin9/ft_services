/usr/bin/telegraf &

/usr/bin/mysql_install_db --datadir=/var/lib/mysql

/usr/bin/mysqld --user=root --init_file=/init_file & sleep 3

mysql wordpress -u root < wordpress.sql

tail -f /dev/null