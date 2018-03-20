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
