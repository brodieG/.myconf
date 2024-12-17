# Multi-user

https://github.com/orgs/Homebrew/discussions/5480

Leads to using home brew with `sudo -u hb brew ...` but not clear if that means
the installed stuff also needs to be used that way?

Some clarification of what is meant:

https://www.codejam.info/2021/11/homebrew-multi-user.html

Seems like things are globally installed so should be usable by everyone (they
are, we tested by installing b2 cli app from Brodie and running it from the main
account).

# Homebrew installation notes

Had to sudo a couple of zsh folders for the backblaze b2 cli to intall.

# Homebrew installation notes (very old, predates apple silicon)

> These instructions are probably invalid now.

Main problem is that we need r+w for or user to /usr/local/bin and other places,
but that conflicts both with multi-user machines as well as with backup and
other user management scripts.  

So instead we try (last tried on 3/2021):

```
sudo chown milberg:admin /usr/local/Homebrew  # run just once
sudo chown milberg /usr/local/bin
sudo chown milberg /usr/local/share/pkgconfig

brew install ...

sudo chown root /usr/local/bin
sudo chown root /usr/local/share/pkgconfig
```

Note it matters what the actual folder is.

Also, had to deal with:

```
Warning: your HOMEBREW_PREFIX is set to /usr/local but HOMEBREW_CELLAR is set
to /usr/local/Homebrew/Cellar. Your current HOMEBREW_CELLAR location will stop
you being able to use all the binary packages (bottles) Homebrew provides. We
recommend you move your HOMEBREW_CELLAR to /usr/local/Cellar which will get you
access to all bottles."
```

With[1]:

```
 brew bundle dump
 rm -rf /usr/local/Homebrew/Cellar
 brew bundle
```

[1]: https://github.com/Homebrew/brew/issues/2457


# Backstory:

Homebrew wants to chmod a bunch of directories to g+rwx.  Don't feel super
comfortable with that, but think it is probably okay.  Some discussion of the
[issue on github][1].

[1]: https://github.com/Homebrew/legacy-homebrew/issues/9953

Further confirming the problem (**THINK CAREFULLY ABOUT DOING THIS, NOT SURE
IT'S OKAY WITH DCE CONFIG**):

Actually ran into this issue again, possibly after some OSX upgrades.  This
time, it was because I couldn't uninstall things in /usr/local/bin even though I
had rwx to them because /usr/local/bin itself was root.


