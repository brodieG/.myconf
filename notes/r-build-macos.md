# Build on Mac

See https://mac.r-project.org/tools/, need gfortran.

Don't seem to need to add gfortran to path when installing.

    configure --with-recommended-packages=no --with-x=no

Need to figure out what's wrong with:

    checking if bzip2 version >= 1.0.6... no
    checking whether bzip2 support suffices... configure: error: bzip2 library and headers are required

Given that:

    bzip2 --version
    bzip2, a block-sorting file compressor.  Version 1.0.8, 13-Jul-2019.

This turned out to be because newer versions of xcode no longer auto-include
some headers, so we had to add:

    #include <stdlib.h> // for exit
    #include <string.h> // for strcmp

In places that used those functions (both bzip2 test, and some other place for
enabling https).  In other words, the capability tests were just failing to run
completely, and that was being diagnosed as a capability miss.

Just hacked directly the config file and didn't bother with the
m4 code.  Didn't figure out where to look to see the error (in theory it is in
config.log, but didn't see).  That allowed the configure to complete.

Bah, failed with:

    gfortran  -fopenmp -fPIC  -g -O2  -c ../../../../R-3.3.3/src/modules/lapack/cmplx.f -o cmplx.o
    ../../../../R-3.3.3/src/modules/lapack/cmplx.f:55915:56:

    33404 |      $                        K, M-K, ONE, C( K+1, 1 ), LDC,
          |                                      2                  
    ......
    55915 |                   CALL ZGEMM( 'N', 'N', N, IV, N-KI+IV, ONE,
          |                                                        1
    Error: Type mismatch between actual argument at (1) and actual argument at (2) (REAL(8)/COMPLEX(8)).

Then tried with a newer version, but then that needed PCRE2 with JIT disabled, and
didn't bother to go through with that.  Did try Simon's recipes, but that failed
and I gave up without trying hard.

Instead, I settled on installing old versions of R in the ubuntu VM.
