Don't use the typical `gdb programname`.  Instead:

```
R -d gdb
```

Otherwise see [RMS's tutorial][1].

To add a breakpoint after starting R:

* ^C
* break whatever
* continue

To create a temporary memory allocation to use elsewhere (from memory, may be
incorrect):

* set $x=(int){1}
* call fun(&$x)

This could be wrong, but it's possible to do something of the sort.

[1]: http://unknownroad.com/rtfm/gdbtut/gdbtoc.html

