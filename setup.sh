minikube delete
minikube start --driver=docker

eval $(minikube docker-env)
minikube addons enable metallb

while true; do
  kubectl -n kube-system get pod | grep -i Pending 1> /dev/null 2>&1
  if [ $? == 0 ] ; then
     echo "Cluster is not ready, sleeping"
    sleep 1
  else
    break
  fi
done

docker build -t nginx_alpine srcs/nginx &> /dev/null
docker build -t wordpress_alpine srcs/wordpress &> /dev/null
docker build -t mysql_alpine srcs/mysql &> /dev/null
docker build -t phpmyadmin_alpine srcs/phpmyadmin &> /dev/null
docker build -t ftps_alpine srcs/ftps &> /dev/null
docker build -t grafana_alpine srcs/grafana &> /dev/null
docker build -t influxdb_alpine srcs/influxdb &> /dev/null

kubectl apply -f srcs/yaml_metallb/metallb.yaml &> /dev/null
kubectl apply -f srcs/yaml_volumes/influxdb.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/influxdb.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/influxdb.yaml &> /dev/null
kubectl apply -f srcs/yaml_volumes/mysql.yaml &> /dev/null

kubectl apply -f srcs/yaml_deployments/nginx.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/wordpress.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/mysql.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/phpmyadmin.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/ftps.yaml &> /dev/null
kubectl apply -f srcs/yaml_deployments/grafana.yaml &> /dev/null

kubectl apply -f srcs/yaml_services/nginx.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/wordpress.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/mysql.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/phpmyadmin.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/ftps.yaml &> /dev/null
kubectl apply -f srcs/yaml_services/grafana.yaml &> /dev/null

#PhpMyAdmin: wp_admin 1010"
#Wordpress: agoodwin 12345"
#grafana: admin admin"
#ftps: ftp_admin 01010"

minikube dashboard &
