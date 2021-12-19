This seems simplest:

```
echo e1 | xxd -p -r | xxd -b
echo e199b1 | xxd -p -r | xxd -b
echo 7ff00000 | xxd -p -r | xxd -b
echo fc9a81808285 | xxd -p -r | xxd -b
echo 0x7ff80000 | xxd -p -r | xxd -b
echo 0ff8 | xxd -p -r | xxd -b
```

Decimal to hex to bin:

```
printf "%08x" 4088 | xxd -p -r | xxd -b
```
