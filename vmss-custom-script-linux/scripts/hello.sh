apt-get -y update
apt-get install -y mc
apt-get install -y docker.io
docker run -it -p 80:80 yeasy/simple-web
