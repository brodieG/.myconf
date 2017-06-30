# Valgrind

Starting with [Ushey post](https://kevinushey.github.io/blog/2015/04/05/debugging-with-valgrind/)

```
brew install valgrind --HEAD
```

Got some warnings about not being able to write to /usr/local/bin.  Looked
around, and settled on:

```
sudo chown -R brodie:admin /usr/local/bin
```
