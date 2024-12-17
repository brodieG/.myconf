# .myconf NOTES

## Set-up

1. Clone Directory
2. Create symlinks

## Symlinks

Might need to remove some of these if they already exist as files.  Probably
good to run a diff before symlink to avoid screwing stuff up.

```
ln -s ~/.myconf/.bash_profile ~/.bash_profile

ln -s ~/.myconf/.gitconfig ~/.gitconfig
ln -s ~/.myconf/.gitignore_global ~/.gitignore_global

ln -s ~/.myconf/.Rprofile ~/.Rprofile
ln -s ~/.myconf/.Renviron ~/.Renviron
ln -s ~/.myconf/.R/ ~/.R
```

Maybe some others:

```
ln -s ~/.myconf/vagrant/Vagrantfile ~/vagrant/Vagrantfile
ln -s ~/.myconf/vagrant/bootstrap.sh ~/vagrant/bootstrap.sh
```

