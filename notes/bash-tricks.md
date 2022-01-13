
## Copyright Update

```
find . -name "*.c" -type f -print \
  | xargs sed -i '' \
  's/Copyright (C) 2021/Copyright (C)/'
```
