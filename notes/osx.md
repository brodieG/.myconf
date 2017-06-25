# OSX

## Sierrra

### Key repeat

From [Marian](http://marianposaceanu.com/articles/macos-sierra-upgrade-from-a-developers-perspective):

```
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Note: these can be reset back to their default via:

defaults delete NSGlobalDomain KeyRepeat
defaults delete NSGlobalDomain InitialKeyRepeat
```

