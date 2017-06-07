apt-get -y update
apt-get install -y mc

(echo n; echo p; echo 1; echo ; echo ; echo w) | sudo fdisk /dev/sdc
sudo mkfs -t ext4 /dev/sdc1
sudo mkdir /data && sudo mount /dev/sdc1 /data