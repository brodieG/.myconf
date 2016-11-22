# Homebrew installation notes

Homebrew wants to chmod a bunch of directories to g+rwx.  Don't feel super
comfortable with that, but think it is probably okay.  Some discussion of the [issue on github](https://github.com/Homebrew/legacy-homebrew/issues/9953)

run:
```
/usr/bin/ruby -e "$(curl -fsSL
https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Turn off analytics:
```
brew analytics off
```
