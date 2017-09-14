List of checks to run on compiled packages

## Compilation Settings

```
CFLAGS += -Wextra -pedantic -Wuninitialized -Wstrict-overflow
```

## Valgrind

Will require valgrind installed (see valgrind notes), then:

```
R CMD check --use-valgrind <pkg.tar.ball>
```

Also, potentially add an `-O0` to the compilation flags?  Have vague memory of
that being recommended for the default `memcheck` tests.

## Rchck

Easiest set up I've figured is to use the vagrant image [Tomas Kalibera
provides](https://github.com/kalibera/rchk), although initial set-up takes quite
a while.

## Rcnst

Also a [Tomas Kalibera special](https://github.com/kalibera/cran-checks/blob/master/rcnst/README.txt).

```
env R_COMPILE_PKGS=1 R CMD build .
env R_JIT_STRATEGY=4 R_CHECK_CONSTANTS=5 R CMD check <pkg.tar.ball>

# env R_COMPILE_PKGS=1 R_JIT_STRATEGY=4 R_CHECK_CONSTANTS=5 R
```

