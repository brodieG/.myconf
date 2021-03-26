To disassemble:

```
objdump rowsum3.o -drSt -M intel
objdump colsum.o -drSt -M intel
```

Comment out source lines:

```
%s/^\(\s\+[0-9a-f]\+:\)\@!/# \1/gc
```
