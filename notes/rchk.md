## rchk

This install takes forever because it requires building R, getting ubuntu
16.xx, etc.

1. Clone https://github.com/kalibera/rchk into vagrant folder.
2. cd into that folder (the `image` folder)
3. vagrant up
4. Follow instructions in readme

We had an issue where we needed to update the LLVM installation, and to succeed
we had to `vagrant destroy && vagrant up`.

Helpful things:

* use `svn update` instead of checkout after first d/l
* copy the tar.gz into vagrant sync folder:

```
R CMD build .
mkdir ~/vagrant/rchk/images/repos
cp xx.tar.gz ~/vagrant/rchk/images/repos

# then in vagrant instance

./bin/R
install.packages('/vagrant/repos/xx.tar.gz')
```
