List of checks to run on compiled packages

## Compilation Settings

Err, don't quite recall what all these are, and why they are here.

```
CFLAGS += -Wextra -pedantic -Wuninitialized -Wstrict-overflow -fsanitize=alignment,bool,bounds,enum,float-cast-overflow,float-divide-by-zero,function,integer-divide-by-zero,nonnull-attribute,null,object-size,return,returns-nonnull-attribute,shift,signed-integer-overflow,unreachable,unsigned-integer-overflow,vla-bound,vptr
```

## Valgrind

Will require valgrind installed (see valgrind notes), then:

```
R CMD check --use-valgrind <pkg.tar.ball>
```

Also, potentially add an `-O0` to the compilation flags?  Have vague memory of
that being recommended for the default `memcheck` tests.  Actually, this does
seem to make a difference as we detected some `memchr` access errors that were
not showing up otherwise (those might be spurious though).

## Rchck

Easiest set up I've figured is to use the vagrant image [Tomas Kalibera
provides](https://github.com/kalibera/rchk), although initial set-up takes quite
a while.

Instructions we used to check package `vetr` on branch issue43a:

```
cd ~
wget https://codeload.github.com/brodieG/vetr/zip/issue43a
unzip issue43a
cd trunk/
bin/R
# remove.packages('vetr')
# install.packages(repos=NULL, '~/vetr-issue43a')
/opt/rchk/scripts/check_package.sh vetr
less packages/lib/vetr/libs/vetr.so.bcheck
```

Also, at some point had to bring down RAM usage in the `rchk/image/config.yml`
file:

```
# for 2G machine:
vm_memory: 2048
bcheck_max_states: 375000
callocators_max_states: 250000
```

## Rcnst

Also a [Tomas Kalibera special](https://github.com/kalibera/cran-checks/blob/master/rcnst/README.txt).

```
env R_COMPILE_PKGS=1 R CMD build .
env R_JIT_STRATEGY=4 R_CHECK_CONSTANTS=5 R CMD check 

# env R_COMPILE_PKGS=1 R_JIT_STRATEGY=4 R_CHECK_CONSTANTS=5 R
```

