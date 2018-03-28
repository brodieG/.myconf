# Valgrind

Starting with [Ushey post](https://kevinushey.github.io/blog/2015/04/05/debugging-with-valgrind/)

*UPDATE*: we really need to use the instrumented version of R as in WCHs docker
containers, b/c otherwise we don't replicate what CRAN does.

```
brew install valgrind --HEAD
```

Got some warnings about not being able to write to /usr/local/bin.  Looked
around, and settled on:

```
sudo chown -R brodie:admin /usr/local/bin
```

This is apparently somewhat controversial since that folder is not a single user
folder, so presumably it shouldn't be owned by a single user, but since my
system is single user it seemed like the best of bad options.

Actually ran into this issue again, possibly after some OSX upgrades.  This
time, it was because I couldn't uninstall things in /usr/local/bin even though I
had rwx to them because /usr/local/bin itself was root.

