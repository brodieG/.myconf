#!/usr/bin/env bash

echo "---> update"
apt-get update
echo "---> add cran repo"
apt-get install -y software-properties-common
add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu precise/"
add-apt-repository ppa:marutter/rrutter
echo "---> add keys"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
echo "---> update again"
apt-get update
echo "---> install R"
apt-get install -y r-base-core
apt-get install -y r-base
apt-get install -y r-base-dev  # note, this is not r-devel

apt-get install git  # needs sudo?
apt-get install libssl0.9.8
apt-get install libcurl4-openssl-dev


# R devel stuff

apt-get install subversion ccache
mkdir ~/svn/
cd ~/svn/
svn co https://svn.r-project.org/R/trunk r-devel/R
cd ~

mkdir rdevelscripts
cd rdevelscripts

# wget https://gist.githubusercontent.com/marutter/3310159/raw/ea44736a9b88fb00af1c4f4766288cdffb973874/build-R-devel
# wget https://gist.githubusercontent.com/marutter/3310329/raw/001674ed91bf3c774f242895ee9f2e2661c9ead2/R-devel.sh
# 
# sh build-R-devel

# Docker set-up https://docs.docker.com/engine/installation/linux/ubuntulinux/

apt-get install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

touch /etc/apt/sources.list.d/docker.list
sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list'

apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine
apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-get install docker-engine
service docker start

# Rocker, maybe we only need drd?  r-devel is a lot of MBs and not at all clear
# it is actually needed to get the actual rdevel version

docker pull rocker/r-devel
docker pull rocker/drd

## The following steps need to be run manually
# 
# sudo docker run -ti rocker/drd /bin/bash
# apt-get install libssl-dev
# apt-get install libssh2-1-dev
# exit
# sudo docker ps -a   # find the relevant container, and commit
# sudo docker commit -m "Added libssl" f3e0a40cd92d brodie/drd
# 
#
#
# # launch Dev version
# sudo docker run -ti brodie/drd20161030 /bin/bash
# sudo docker run --rm -ti brodie/drd RD

sudo docker run -ti brodie/drd /bin/bash
