This seems simplest:

```
echo e1 | xxd -p -r | xxd -b
echo e199b1 | xxd -p -r | xxd -b
echo eda080 | xxd -p -r | xxd -b
echo fc9a81808285 | xxd -p -r | xxd -b

```

Lost of complications if we try to go directly to binary.
