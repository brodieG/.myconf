## Overview

I don't recognize Tomas's instructions anymore, so instead I'm going to try to
do it via the Rhub docker[3].  Another option would be to use Josh's file on
which Rhub is based[4].

Tomas provides [rchk tools](https://github.com/kalibera/rchk).  These include
directions on how to build/install, but note that not all instructions apply to
Vagrant use.  For example, there are [step-by-step instructions][1] for setting
things up (these are old?), but at the same time there [are scripts][2] that do
this slightly differently, so I think we can ignore the step by step
instructions.

[1]: https://github.com/kalibera/rchk/blob/1684a5e53e3bffe6886953ae9008620e492c2ca2/doc/BUILDING.md

**IMPORTANT**: be sure to comment out any 'config.site' changes as they appear
to overwrite the compilation flags set by 'cmpconfig.inc'?

## Switch to RHub Docker

It also looks like we can do this stuff directly from R, but it requires us
figuring out how to configure Rhub v2 with the github tokens and it seems like
it doesn't just work with [ssh and permissions][5] for the new granular GH
tokens don't seem documented so we shied away from trying this.

### Current (2024-06-19)

**Update 2024-06-19**: Looks like the rhub image is no longer maintained and has
been switched to a new source.

Looks like the docker containers from the original link have not been updated.
So let's go to the [new source][6].  This provides [new instructions][7]:

    docker pull ghcr.io/r-hub/containers/rchk:latest 
    docker run --rm -ti -v `pwd`:/check ghcr.io/r-hub/containers/rchk:latest
    r-check
    cat ./opt/R/devel-rchk/packages/lib/vetr/libs/vetr.so.bcheck

For some reason only the bcheck tool is enabled in
`/opt/R/devel-rchk/bin/rchk.sh` (maacheck and fficheck commented out).

We try enabling it with (in the docker session):

    apt-get update
    apt-get install vim-tiny  # bunch of errors
    vim.tiny /opt/R/devel-rchk/bin/rchk.sh

And adding back maacheck.  In our case it only produced an empty file, but
presumably that's because it had no errors?  Also after we added maacheck it
didn't seem to run bcheck again, so we'll have to watch out for that in the
future.

### Previous


    docker pull rhub/ubuntu-rchk
    docker run --rm -ti -v $(pwd):/mydir rhub/ubuntu-rchk
    cd /mydir
    rchk.sh vetr_0.2.14.tar.gz

For some reason the cat output didn't automatically produce, perhaps because of
the too many states error, but then we see:

    cat /home/docker/R-svn/packages/lib/vetr/libs/vetr.so.bcheck 
    ## ERROR: too many states (abstraction error?) in function strptime_internal
    ## ERROR: too many states (abstraction error?) in function RunGenCollect
    ## Analyzed 189 functions, traversed 166389 states.
    cat /home/docker/R-svn/packages/lib/vetr/libs/vetr.so.maacheck 

So I think it's okay.

**Update 2024-06-19**: Looks like rhub image is no longer maintained (see above
section).  We're seeing error:

    This script has to be run from the root of R source directory with
    bitcode files (e.g. src/main/R.bin exists) or R binary installation
    (./build/lib/R/bin/exec/R exists).

Looking around in /home/docker/R-svn it's not even clear that the R binary has
been built:

    ./home/docker/R-svn/bin/R
    bash: ./home/docker/R-svn/bin/R: No such file or directory

It has not, in fact if we run (from ~/R-svn):

        ~/R-svn$ ~/rchk/scripts/build_r.sh

We get compilation errors.

[3]: https://hub.docker.com/r/rhub/ubuntu-rchk
[4]: https://github.com/joshuaulrich/rchk-docker/blob/master/Dockerfile
[5]: https://github.com/r-hub/rhub/issues/601
[6]: https://r-hub.github.io/containers/containers.html#rchk
[7]: https://r-hub.github.io/containers/local.html

## General R Installs With R Check

See r-build.md

