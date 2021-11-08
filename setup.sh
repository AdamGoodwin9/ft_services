minikube delete
minikube start --driver=docker

eval $(minikube docker-env)
minikube addons enable metallb

echo "Waiting for cluster to be ready"
while true; do
  kubectl -n kube-system get pod | grep -i Pending 1> /dev/null 2>&1
  if [ $? == 0 ] ; then
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

kubectl apply -f srcs/yaml/metallb.yaml &> /dev/null
kubectl apply -f srcs/yaml/influxdb.yaml &> /dev/null
kubectl apply -f srcs/yaml/mysql.yaml &> /dev/null
kubectl apply -f srcs/yaml/nginx.yaml &> /dev/null
kubectl apply -f srcs/yaml/wordpress.yaml &> /dev/null
kubectl apply -f srcs/yaml/phpmyadmin.yaml &> /dev/null
kubectl apply -f srcs/yaml/ftps.yaml &> /dev/null
kubectl apply -f srcs/yaml/grafana.yaml &> /dev/null

kubectl get service

echo PhpMyAdmin: agoodwin 1234
echo Wordpress: agoodwin 12345
echo grafana: admin admin
echo influxdb: agoodwin 1234
echo ftps: agoodwin 1234

minikube dashboard &