# Docker

This assumes we're running docker under a vagrant instance (see the vagrant
folder, in particular `boostrap.sh`

```
service docker start
sudo docker pull rocker/drd  # Development version
sudo docker run -ti rocker/drd /bin/bash
apt-get update
apt-get install -y libssl-dev
apt-get install -y libssh2-1-dev
apt-get install -y git
apt-get install -y vim-gtk  # normal vim doesn't have +clipboard

mkdir ~/.vimswap
mkdir ~/.vim
git clone --recursive https://github.com/brodieG/vim.git ~/.vim
echo "source ~/.vim/vimrc" > ~/.vimrc

RDscript -e "install.packages(c('devtools', 'testthat', 'knitr', 'rmarkdown'))"
```

The following steps need to be run manually; also, can repeat process and
keep updating images via commits

```
sudo docker ps -a   # find the relevant container, and commit
sudo docker commit -m "configured packages" 98b5522219e0 brodie/drd

# launch Dev version
sudo docker run -ti brodie/drd /bin/bash
RD  # for devel R version once in docker image
```

Note, possible alternative to the commits [from SO](https://stackoverflow.com/a/19616598/2725969):

```
sudo docker start 80cdfdd00f76 # restart it in the background
sudo docker attach 80cdfdd00f76 # reattach the terminal & stdin>
```

# Deleting images

```
# containers
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)

# images
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
sudo docker rmi $(sudo docker images -a -q)
```

# Updating drd

```
sudo docker pull rocker/drd  # Development version
```

Unfortunately this doesn't automatically update our image...
