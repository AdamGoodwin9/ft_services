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

echo building nginx image
docker build -t nginx-img srcs/nginx &> /dev/null
echo building wordpress image
docker build -t wordpress-img srcs/wordpress &> /dev/null
echo building mysql image
docker build -t mysql-img srcs/mysql &> /dev/null
echo building phpmyadmin image
docker build -t phpmyadmin-img srcs/phpmyadmin &> /dev/null
echo building ftps image
docker build -t ftps-img srcs/ftps &> /dev/null
echo building grafana image
docker build -t grafana-img srcs/grafana &> /dev/null
echo building influxdb image
docker build -t influxdb-img srcs/influxdb &> /dev/null

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

kubectl get service

echo PhpMyAdmin: agoodwin 1234
echo Wordpress: agoodwin 12345
echo grafana: agoodwin 1234
echo ftps: agoodwin 1234

minikube dashboard &