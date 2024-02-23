# Valgrind

## Usage

BDR provides a [valgrind config][1] that includes a suppression file and fuller
config directives which we've copied in to 'r-valgrind.supp' and placed a copy
of the file in $RSRC (`setenv` instructions are for specific shell type (not
Bash)), see "r-build.md" for $RSRC $RBUILD.

First, set "config.site":

    CFLAGS="-g -O2 -Wall -pedantic -mtune=native"
    CXXFLAGS="-g -O2 -Wall -pedantic -mtune=native"
    FFLAGS="-g -O2 -mtune=native"
    FCFLAGS="-g -O2 -mtune=native"

Configure **REMEMBER config.site**:

    cd $RBUILD
    $RSRC/configure -C --with-valgrind-instrumentation=2 --with-system-valgrind-headers --with-recommended-packages=no

And environment variables (seem to be runtime, at least the TK one)

    RJAVA_JVM_STACK_WORKAROUND=0 R_DONT_USE_TK=true LC_CTYPE=en_US.utf8 $RBUILD/bin/R -d "valgrind --suppressions=$RSRC/r-valgrind.supp --track-origins=yes" --no-restore --no-save

    RJAVA_JVM_STACK_WORKAROUND=0 R_DONT_USE_TK=true LC_CTYPE=en_US.utf8 $RBUILD/bin/R -d "valgrind --track-origins=yes"

See also [Ushey post][2].

## Packages:

Once R is build, or available via docker, etc:

> Make sure ~/.R/Makevars has -O0 setting

Eh, not sure this is good advice.  In fact it might be bad in that some bad
accesses only become apparent under optimized code?


[1]: https://www.stats.ox.ac.uk/pub/bdr/memtests/README.txt
[2]: https://kevinushey.github.io/blog/2015/04/05/debugging-with-valgrind/
