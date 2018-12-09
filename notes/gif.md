## Making GIFs

From [dergachev](https://gist.github.com/dergachev/4627207), [copied for
posterity](https://gist.github.com/brodieG/fa0234fce4583f0e77d53ebc18fab89c).

## From PNGs

```
ffmpeg -pattern_type glob -i '*.png' -vcodec gif out.gif
```
