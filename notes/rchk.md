## Overview

Tomas provides [rchk tools](https://github.com/kalibera/rchk).  These include
directions on how to build/install, but note that not all instructions apply to
Vagrant use.  For example, there are [step-by-step instructions][1] for setting
things up (these are old?), but at the same time there [are scripts][2] that do
this slightly differently, so I think we can ignore the step by step
instructions.

[1]: https://github.com/kalibera/rchk/blob/1684a5e53e3bffe6886953ae9008620e492c2ca2/doc/BUILDING.md

**IMPORTANT**: be sure to comment out any 'config.site' changes as they appear
to overwrite the compilation flags set by 'cmpconfig.inc'?

## Switch to RHub Docker

I don't recognize Tomas's instructions anymore, so instead I'm going to try to
do it via the Rhub docker[3].  Another option would be to use Josh's file on
which Rhub is based[4].

    docker pull rhub/ubuntu-rchk
    docker run --rm -ti -v $(pwd):/mydir rhub/ubuntu-rchk
    cd /mydir
    rchk.sh vetr_0.2.14.tar.gz

For some reason the cat output didn't automatically produce, perhaps because of
the too many states error, but then we see:

    cat /home/docker/R-svn/packages/lib/vetr/libs/vetr.so.bcheck 
    ## ERROR: too many states (abstraction error?) in function strptime_internal
    ## ERROR: too many states (abstraction error?) in function RunGenCollect
    ## Analyzed 189 functions, traversed 166389 states.
    cat /home/docker/R-svn/packages/lib/vetr/libs/vetr.so.maacheck 

So I think it's okay.

It also looks like we can do this stuff directly from R:

[3]: https://hub.docker.com/r/rhub/ubuntu-rchk
[4]: https://github.com/joshuaulrich/rchk-docker/blob/master/Dockerfile

## Vagrant Config

Easiest set up I've figured is to use the vagrant image , although initial
set-up takes forever because it requires building R, getting ubuntu 16.xx, etc.

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

## Checking R

Follow same instructions for packages,

Then, run some version (TBD) of:

```
/opt/rchk/scripts/check_r.sh
```

One issue is that config.site affects things.

## X11 forwarding

```
sudo apt-get install xauth
sudo apt-get install xorg openbox  # maybe?
```

From
[coderwall](https://coderwall.com/p/ozhfva/run-graphical-programs-within-vagrantboxes)

Add to Vagrantfile:

```
  config.ssh.forward_x11 = true
```

And then:

```
 vagrant ssh -- -X
```

This allowed me to open xclock.

## General R Installs With R Check

See r-build.md

