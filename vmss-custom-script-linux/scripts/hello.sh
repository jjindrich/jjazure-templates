until apt-get -y update && apt-get -y install docker.io
do
 echo "Try again"
 sleep 2
done
docker run -d --restart="always" -p 80:80 yeasy/simple-web
