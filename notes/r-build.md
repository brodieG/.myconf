## Base Build

So it turns out the `rchk` image is a pretty good starting point for building
our own R packages, so from within, we can do, for example:

```
sudo apt-get install valgrind
cd ~/trunk
./configure --with-valgrind-instrumentation=2
make

# make sure ~/.R/Makevars has -O0 setting

./bin/R -d "valgrind --track-origins=yes"
```

## Configuration

Having been able to figure out how to get `config.site` to take.  R-inst
suggests that editing the file as is in the build directory is sufficient, but
changes appear to be ignored.

This OTOH works:

```
CFLAGS="-g O0" ./configure
```

These should then show up on compilation.

## Checking

```
make check | tee check.out
make check-devel
make check-all
```

## Adding Features

### Overview

A few things I added that I no longer remember how to do:

* GDB?
* Updated the perl engine.

### X11

Trying to test in GUI mode.

```
sudo apt-get install xorg openbox
```

I think another command was needed when ssh'ing into the vagrant session to get
this to work, but I don't remember.  Maybe:

```
vagrant ssh -- -X
./bin/R -g Tk
```

This worked and produced a clunky X-code window with the R session running in
it.

### Compilers
