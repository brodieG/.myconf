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

    objdump -d src/main/print.o | less   # 
    objdump -t src/main/print.o | less   # 


## clang/OS X

Can't quite figure out how to get line numbers and all that nicely.

    objdump -drSt --x86-asm-syntax intel a.out

