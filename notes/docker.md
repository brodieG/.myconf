# Docker

## Under Vagrant

### Install

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

```
A simple install:
```
mkdir repos
cd repos
wget https://github.com/brodieG/<PKG>/archive/<BRANCH>.zip
unzip <BRANCH>.zip
```

Or the following, but this installs a bunch of stuff (some of it needed to run
the tests with R CMD check, e.g. `knitr`):

```
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
sudo docker start d5c6c1a63dbd # restart it in the background
sudo docker attach d5c6c1a63dbd # reattach the terminal & stdin>
```

### Deleting images

```
# containers
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)

# images
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
sudo docker rmi $(sudo docker images -a -q)
```

### Updating drd

```
sudo docker pull rocker/drd  # Development version
sudo docker pull rocker/r-devel  # Development version
```

Unfortunately this doesn't automatically update our image...

## On OSX

From [Jim Hester's docker guide](http://www.jimhester.com/2017/10/13/docker/):

Remember to delete o,so files.

```
# Change to the directory
cd /a/certain/directory

# Start docker in that directory, mapping the current directory to a directory
# in the docker image using the `rocker/r-apt:trusty` container and starting a
# bash prompt in that container.

docker run -v "$(pwd)":"/opt/$(basename $(pwd))" -it rocker/drd /bin/bash
docker run -v "$(pwd)":"/opt/$(basename $(pwd))" -it rocker/r-apt:trusty /bin/bash
docker run -v "$(pwd)":"/opt/$(basename $(pwd))" -it rocker/r-devel-san /bin/bash
docker run -v "$(pwd)":"/opt/$(basename $(pwd))" --cap-add SYS_PTRACE -it rocker/r-devel-ubsan-clang /bin/bash
docker run -v "$(pwd)":"/opt/$(basename $(pwd))" -it rocker/r-ver:3.1 /bin/bash

cd /opt/<pkg_name>

```

## Winston Chang Docker

[docker-hub](https://hub.docker.com/r/wch1/r-debug/).

Lots of goodies there.

```
docker pull wch1/r-debug

docker run --rm -ti --security-opt seccomp=unconfined wch1/r-debug

# Then you can run R-devel with:
RD

# Or, to run one of the other builds:
RDvalgrind -d "valgrind --track-origins=yes"
RDsan  # does not run UB, see below.
RDcsan # does run UB
RDstrictbarrier
RDassertthread
```

In order to correctly run `RDsan`, we need something like:

```
echo 'CC=gcc -std=gnu99 -fsanitize=undefined -fno-omit-frame-pointer' > \
  ~/.R/Makevars &&
  RDsan &&
  rm ~/.R/Makevars
```

The --security-opt seccomp=unconfined is needed to use gdb in the container. Without it, you'll see a message like warning: Error disabling address space randomization: Operation not permitted, and R will fail to start in the debugger.

To mount a local directory in the docker container:

```
docker run --rm -ti --security-opt seccomp=unconfined -v /my/local/dir:/mydir wch1/r-debug

# Mount the current host directory at /mydir
docker run --rm -ti --security-opt seccomp=unconfined -v $(pwd):/mydir wch1/r-debug
docker run --rm -ti -v $(pwd):/mydir wch1/r-debug

docker run --rm -ti --security-opt seccomp=unconfined -v $(pwd):/mydir rocker/r-base /bin/bash

docker run --rm -ti -v $(pwd):/mydir rocker/drd /bin/bash


```

If you want to have multiple terminals in the same container, start the container with --name and use docker exec from another terminal:

```
# Start container
docker run --rm -ti --name rd --security-opt seccomp=unconfined wch1/r-debug

# In another terminal, get a bash prompt in the container
docker exec -ti rd /bin/bash
```
 
