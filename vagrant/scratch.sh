
sudo apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine
apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-get install docker-engine
service docker start
