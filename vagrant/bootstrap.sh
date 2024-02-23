#!/usr/bin/env bash

#echo "---> update"
#apt-get update
#echo "---> add cran repo"
#apt-get install -y software-properties-common
#add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu precise/"
#add-apt-repository ppa:marutter/rrutter
#echo "---> add keys"
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
#echo "---> update again"
#apt-get update
#echo "---> install R"
#apt-get install -y r-base-core
#apt-get install -y r-base
#apt-get install -y r-base-dev  # note, this is not r-devel

apt-get install -y git  # needs sudo?
#apt-get install -y libssl0.9.8
#apt-get install -y libcurl4-openssl-dev

# valgrind, note this was installed manually

apt-get install -y valgrind

# Docker set-up https://docs.docker.com/engine/installation/linux/ubuntulinux/

apt-get install -y apt-transport-https ca-certificates
# apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

#touch /etc/apt/sources.list.d/docker.list
#sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list'
#
#apt-get update
#apt-get purge lxc-docker
#apt-cache policy docker-engine
#apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
#apt-get install -y docker-engine

# see notes/docker.md for more docker stuff

# Repository setup, after clone step copied from notes

git clone https://github.com/brodieG/.myconf.git ~/.myconf

ln -s ~/.myconf/.gitconfig ~/.gitconfig
ln -s ~/.myconf/.gitignore_global ~/.gitignore_global
ln -s ~/.myconf/.Rprofile ~/.Rprofile
ln -s ~/.myconf/.Renviron ~/.Renviron

ln -s ~/.myconf/.R/ ~/.R
mkdir ~/repos
