# Building R on Windows

## Overview

We have both git bash and Rtools bash (and a few MinGW).  Use gitbash for git.

## References

* https://github.com/r-windows/
* https://cran.r-project.org/bin/windows/Rtools/
* https://github.com/r-windows/r-base#readme

## r-base

Things to modify:

* quick-build.sh so it doesn't nuke the R directory every time
* Mkrules.local.in:
    * DEBUG = TRUE
    * EOPTS = -O0

## Pacman

Use Rtools Bash.  Seems to only have the mingw repos set-up by default, so not
all common software is there.  The gitbash thing has more?

For rtools, go to '/etc/pacman.conf' and enable the 'msys' repository to get
more stuff, but watch out it could mess everything up!

## Subversion

Can use tortoise, but gitbash also seems to have it installed.


