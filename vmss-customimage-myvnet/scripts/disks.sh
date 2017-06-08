apt-get -y update
apt-get install -y mc

(echo n; echo p; echo 1; echo ; echo ; echo w) | fdisk /dev/sdc
mkfs -t ext4 /dev/sdc1
mkdir /data && mount /dev/sdc1 /data