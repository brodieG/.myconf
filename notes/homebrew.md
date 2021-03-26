# Homebrew installation notes

Homebrew wants to chmod a bunch of directories to g+rwx.  Don't feel super
comfortable with that, but think it is probably okay.  Some discussion of the
[issue on github][1].

[1]: https://github.com/Homebrew/legacy-homebrew/issues/9953

Further confirming the problem (**THINK CAREFULLY ABOUT DOING THIS, NOT SURE
IT'S OKAY WITH DCE CONFIG**):

```
brew install valgrind --HEAD
```

Got some warnings about not being able to write to /usr/local/bin.  Looked
around, and settled on:

```
sudo chown -R brodie:admin /usr/local/bin
sudo chown -R brodie:admin /usr/local/bin
```

> This caused problems with the admin scripts that run on the DCE laptop, so
> really not an option.

This is apparently somewhat controversial since that folder is not a single user
folder, so presumably it shouldn't be owned by a single user, but since my
system is single user it seemed like the best of bad options.

Actually ran into this issue again, possibly after some OSX upgrades.  This
time, it was because I couldn't uninstall things in /usr/local/bin even though I
had rwx to them because /usr/local/bin itself was root.

This time (3/21) I just temporarily set the owner to myself before setting back
to root.

```
sudo chown milberg /usr/local/bin
sudo chown milberg /usr/local/share/pkgconfig

sudo chown root /usr/local/bin
sudo chown root /usr/local/share/pkgconfig

```

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

