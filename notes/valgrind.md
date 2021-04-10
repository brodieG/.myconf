# Valgrind

## Update

Starting with [Ushey post][2]

*UPDATE*: we really need to use the instrumented version of R as in WCHs docker
containers, b/c otherwise we don't replicate what CRAN does.

Another option is `rchk` image, which works well.  Basic config (see full
version later with suppressions, etc.):

    ./configure --with-valgrind-instrumentation=2
    make
    ./bin/R -d "valgrind --track-origins=yes"

BDR provides a [valgrind config][1] that includes a suppression file and fuller
config directives which we've copied in to 'r-valgrind.supp' and symlinked into
the rchk vagrant trunk folder (err, not sure if this is true, but can make it
easy enough)..

Note that the `setenv` instructions are for specific shell type (not Bash).

So, to run (check instructions for updates):

Configured by:

    ./configure -C --with-valgrind-instrumentation=2 --with-system-valgrind-headers

Or:

    ./configure -C --with-valgrind-instrumentation=2 --with-system-valgrind-headers --with-recommended-packages=no

With config.site:

    CFLAGS="-g -O2 -Wall -pedantic -mtune=native"
    CXXFLAGS="-g -O2 -Wall -pedantic -mtune=native"
    FFLAGS="-g -O2 -mtune=native"
    FCFLAGS="-g -O2 -mtune=native"

And environment variables (seem to be runtime, at least the TK one)

    RJAVA_JVM_STACK_WORKAROUND=0 R_DONT_USE_TK=true LC_CTYPE=en_US.utf8 ./bin/R -d "valgrind --suppressions=./r-valgrind.supp"


## Packages:

Once R is build, or available via docker, etc:

> Make sure ~/.R/Makevars has -O0 setting


[1]: https://www.stats.ox.ac.uk/pub/bdr/memtests/README.txt
[2]: https://kevinushey.github.io/blog/2015/04/05/debugging-with-valgrind/
