## gcc

To inspect things binary object, first make sure that the compilation occurs
with the friendliest symbols possible, like:

    CFLAGS="-gdwarf -g3 -O0 -Wall -Wpedantic -std=gnu99" 

To get information on the type of binary:

    file src/main/R.bin 

'R.bin' appears to be the main binary that contains all the o files.  To look at
its symbols:

    nm --format sysv src/main/R.bin | less

Or in BSD format with file names:

    nm src/main/R.bin -l -p | less

An interesting issue with the above is that static variable defined in functions
are not given a file but are given mangled names (e.g. buff.12).

For disassembly it might be easier to use the o files directly:

    objdump rowsum3.o -drSt -M intel
    objdump colsum.o -drSt -M intel

    objdump int-rowsum.o -dlrSt -M intel > int-rowsum.asm

    // for a static file, this works well
    objdump -Sltr --no-show-raw-insn array.o -M intel | less
    objdump -Sltr --no-show-raw-insn array.o -M intel | less

Comment out source lines for syntax highlighting:

    %s/^\(\s\+[0-9a-f]\+:\)\@!/# \1/gc


## clang/OS X

Can't quite figure out how to get line numbers and all that nicely.

    objdump -drSt --x86-asm-syntax intel a.out

For the r2c business it's necessary to generate the dSYM and then instruments
can find it, e.g. after generating the so at the top level we can generate the
dSYM with:

    dsymutil r2c-kny4n4pt1v.so -o r2c-kny4n4pt1v.dSYM

