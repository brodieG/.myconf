## rchk

Easiest set up I've figured is to use the vagrant image [Tomas Kalibera
provides](https://github.com/kalibera/rchk), although initial set-up takes
forever because it requires building R, getting ubuntu 16.xx, etc.

1. Clone https://github.com/kalibera/rchk into vagrant folder.
2. cd into that folder (the `image` folder)
3. vagrant up
4. Follow instructions in README
   * These have changed a lot from the original vanilla ones, but look for
     "Testing the installation"
   * Be sure to use the commands in parenthesis ('starting with
     /opt/rchk/scripts')
5. Remember we can just svn update after initial checkout

We had an issue where we needed to update the LLVM installation, and to succeed
we had to `vagrant destroy && vagrant up`.

We can use the vagrant sync folder.

```
R CMD build .
mkdir ~/vagrant/rchk/images/repos
cp xx.tar.gz ~/vagrant/rchk/image/repos

# then in vagrant instance

./bin/R
install.packages('/vagrant/repos/xx.tar.gz')
```

Also, at some point had to bring down RAM usage in the `rchk/image/config.yml`
file:

```
# for 2G machine:
vm_memory: 2048
bcheck_max_states: 375000
callocators_max_states: 250000
```

## General R Installs With R Check

So it turns out the `rchk` image is a pretty good starting point for building
our own R packages, so from within, we can do, for example:

```
sudo apt-get install valgrind
cd ~/trunk
./config --with-valgrind-instrumentation=2
make

# make sure ~/.R/Makevars has -O0 setting

./bin/R -d "valgrind --track-origins=yes"
```
