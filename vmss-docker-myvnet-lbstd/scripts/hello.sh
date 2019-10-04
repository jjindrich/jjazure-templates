until apt-get -y update && apt-get -y install docker.io
do
 echo "Try again"
 sleep 2
done
docker login -u jjcontainers -p <PASSWORD> jjcontainers.azurecr.io
docker stop $(docker ps -q)
docker run -d --restart="always" -p 80:80 jjcontainers.azurecr.io/jjwebcore:2019051810