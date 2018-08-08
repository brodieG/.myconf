List of checks to run on compiled packages

## Compilation Settings

```
CFLAGS += -O0 -std=c99 -Wextra -pedantic -Wuninitialized -Wstrict-overflow -D_POSIX_C_SOURCE=200112L
```

```
CFLAGS += -O0 -std=c99 -Wextra -pedantic -Wuninitialized -Wmaybe-uninitialized -Wstrict-overflow -D_POSIX_C_SOURCE=200112L
```

Last one is to try to make sure we run in real C99 to avoid issues with BDR.

## Valgrind

Currently we run valgrind by using `RDvalgrind` binary that comes with the
wch-rdebug docker container.  See the docker notes.

## UBSAN

Currently we run UBSAN by using the RD binary that comes with wch/r-debug.

## Rchk

See notes/rchk.md

## Rcnst

Also a [Tomas Kalibera special](https://github.com/kalibera/cran-checks/blob/master/rcnst/README.txt).

```
env R_COMPILE_PKGS=1 R CMD build .
env R_JIT_STRATEGY=4 R_CHECK_CONSTANTS=5 R CMD check 

# env R_COMPILE_PKGS=1 R_JIT_STRATEGY=4 R_CHECK_CONSTANTS=5 R
```

## Other Checks

See the docker file.
