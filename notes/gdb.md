Don't use the typical `gdb programname`.  Instead:

```
R -d gdb
```

To get full macro expansion, etc, see 'r-build.md' notes as we need special
compilation settings.

Otherwise see [RMS's tutorial][1].

To add a breakpoint after starting R:

    ^C
    break whatever
    continue

To create a temporary memory allocation to use elsewhere (from memory, may be
incorrect):

    set $x=(int){1}
    call fun(&$x)

This could be wrong, but it's possible to do something of the sort.

To run instruction by instruction:

    set  disassemble-next-line on
    show disassemble-next-line
    set  disassembly-flavor intel

In Windows (from Kalibera):

> Gdb on Windows is a pain, essentially you need to build with debug
> symbols (preferably without optimizations, so -O0 in EOPTS), the default
> build have debug symbols stripped (set DEBUG=T before running make).
> Then you start gdb on RGui.exe, then "set solib-search-path", run it,
> from RGui menu you do "Break to debugger", then set a breakpoint, then
> continue. I can of course provide more details if you wanted to have a
> look. It may actually be easier to add printf to the CreateProcess to
> see the command line, which I suppose will be correct, and I suppose it
> is some Windows issue/weirdness. We could try in wine, then see if it
> behaves the same there, and if so, debug it there, because there we have
> the sources...


[1]: http://unknownroad.com/rtfm/gdbtut/gdbtoc.html

