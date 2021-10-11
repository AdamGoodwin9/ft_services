./srcs/vm_setup.sh

minikube delete
minikube start --driver=docker --cpus=2
minikube addons enable metrics-server
minikube addons enable dashboard &> /dev/null
minikube addons enable metallb
kubectl apply -f srcs/yaml_metallb/metallb.yaml &> /dev/null
eval $(minikube docker-env)
echo

docker build -t nginx_alpine srcs/nginx
docker build -t wordpress_alpine srcs/wordpress
docker build -t mysql_alpine srcs/mysql
docker build -t phpmyadmin_alpine srcs/phpmyadmin
docker build -t ftps_alpine srcs/ftps
docker build -t grafana_alpine srcs/grafana
docker build -t influxdb_alpine srcs/influxdb

kubectl apply -f srcs/yaml_volumes/mysql.yaml &> /dev/null
kubectl apply -f srcs/yaml_volumes/influxdb.yaml &> /dev/null

kubectl apply -f srcs/yaml_deployments/nginx.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/wordpress.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/mysql.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/phpmyadmin.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/ftps.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/grafana.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/influxdb.yaml &> /dev/null

kubectl apply -f srcs/yaml_services/nginx.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/wordpress.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/mysql.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/phpmyadmin.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/ftps.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/grafana.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/influxdb.yaml &> /dev/null

echo "==============================================================================================="
echo
kubectl get svc
echo "-----------------------------------------------------------------------------------------------------------------"
echo "| Services      | SSH nginx     | PHPMyAdmin    | InfluxDB      | FTPS          | Wordpress     | Grafana       |"
echo "|---------------------------------------------------------------------------------------------------------------|"
echo "| Login         | ssh_admin     | wp_admin      | graf_admin    | ftp_admin     | cclaude       | admin         |"
echo "| Password      | 0101          | 1010          | 10101         | 01010         | cclaude1      | admin         |"
echo "-----------------------------------------------------------------------------------------------------------------\n"
echo "Open 172.17.0.2 in a web browser"