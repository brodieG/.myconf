
## Copyright Update

```
find . -name "*.R" -type f -print \
  | xargs sed -i .bak \
  's/Copyright (C) 2021 Brodie Gaslam/Copyright (C) 2022 Brodie Gaslam/'
```
