# Vagrant Installation

See Also the `rchk` notes.  These may be unrelated!

## Virtual Box Installation

1. dl binaries from [virtual box](https://www.virtualbox.org/)

## Vagrant itself

1. dl binaries from [vagrant](https://www.vagrantup.com/docs/installation/)

Some issues trying to add the trusty box:

```
$ vagrant box add ubuntu/trusty64

The box 'ubuntu/trusty64' could not be found or
could not be accessed in the remote catalog. If this is a private
box on HashiCorp's Atlas, please verify you're logged in via
`vagrant login`. Also, please double-check the name. The expanded
URL and error message are shown below:

URL: ["https://atlas.hashicorp.com/ubuntu/trusty64"]
```

Solution on [git](https://github.com/Varying-Vagrant-Vagrants/VVV/issues/354):

```
sudo rm /opt/vagrant/embedded/bin/curl  # to resolve issue
vagrant box add ubuntu/trusty64
mkdir ~/vagrant
cd ~/vagrant
# At some point needed to do `vagrant init ubuntu/trusty64` for this to work
vagrant init

# Copy links in ~/.myconf/NOTES.md
```

Make sure that the Vagrantfile is still compatible with what we have in
`.myconf`, and if so, then remove and overwrite with symlinks to the stuff in
`.myconf`.  Main issue likely if the box version changes (e.g. from trusty to
whatever comes after trusty).

Also, review `vagrant/bootstrap.sh` to make sure that it is configured
properly.

```
vagrant up
```

## New Boxes

It seems virtual box wants to just provide the default box whatever is in the
Vagrantfile of the image.  I was unable to upgrade to run image with a different
box until after I deleted all the previous boxes from Virtualbox directly, and
then finally was able to get Bionic installed (recognized), even though the
Vagrantfile was asking for that the whole time..

## File System Issues

c.a. 2/2022 we ran into filesystem issues where the mv command would behave
non-blocking allowing code to resume execution before all files were moved, in
particular sub-folders.  This happened on a host OS folder in /vagrant, and
broke tests/reg-packages.R.  We now work around it by using out-of tree R builds
(see r-build.md).
