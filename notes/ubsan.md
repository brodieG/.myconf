# UBSAN

## R Proper

Compiler option, described in WRE 4.3.4[1]. Key is to set the right compiler
options, works better with clang.  In 'config.site':

    CC="clang-10"
    CFLAGS="-g -O2 -Wall -std=gnu99 -fsanitize=undefined -fno-sanitize=float-divide-by-zero"
    MAIN_LDFLAGS="-fsanitize=undefined -fno-sanitize=float-divide-by-zero"

Build is slow, so might make sense to exclude recommended packages.

In practice, found this disappointing.  Got it to detect an integer overflow,
but was not reporting some way OOB writes in an allocated array (maybe it
can't?).

## Packages

Presumably done through ~/.R/Makevars, but **requires** an R build with the
libraries SAN functions baked in.

[1]: https://cran.r-project.org/doc/manuals/R-exts.html#Using-Undefined-Behaviour-Sanitizer


