apt-get -y update
apt-get install -y mc
apt-get install -y docker.io
docker login -u jjcontainers -p <PASSWORD> jjcontainers.azurecr.io
docker stop $(docker ps -q)
docker run -d --restart="always" -p 80:80 jjcontainers.azurecr.io/jjwebcore:2019051810
