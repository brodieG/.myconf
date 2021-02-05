# Building R on Windows

## Overview

We have both git bash and Rtools bash (and a few MinGW).  Use gitbash for git.

## References

* https://github.com/r-windows/
* https://cran.r-project.org/bin/windows/Rtools/
* https://github.com/r-windows/r-base#readme

## r-base

Use R-tools bash.

Installation will require miktek, make sure to install for "all users" so the
install can be found.

Things to modify:

* quick-build.sh so it doesn't nuke the R directory every time
* Mkrules.local.in:
    * DEBUG = TRUE
    * EOPTS = -O0          << and any other CFLAGS!
    * no recommended?

The rtools bashes have their own root structure.

## Pacman

Use Rtools Bash.  Seems to only have the mingw repos set-up by default, so not
all common software is there.  The gitbash thing has more?

For rtools, go to '/etc/pacman.conf' and enable the 'msys' repository to get
more stuff, but watch out it could mess everything up!

Tried doing this to get subversion but I kept getting asked to add a key that I
could not verify corresponding to anyone trusted, so I gave up and went to
tortoise.

## Subversion

Can use tortoise, but gitbash might have it installed.


