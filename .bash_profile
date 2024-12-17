export HISTCONTROL=ignorespace:ignoredups

alias rm='rm -i'
alias vimr='vim -R -'
alias R='R --no-save --no-restore'

alias rcb='R CMD BATCH --vanilla --no-timing'
alias gdni='git diff --no-index -R'

alias cranbuild='(
  cp .Rbuildignore{,.bak}
  echo "not-cran" >> .Rbuildignore
  sudo -u bg R CMD BUILD .
  mv .Rbuildignore{.bak,}
)'

# alias brew="/opt/homebrew/bin/brew"

## thanks Dirk
## Set the prompt to show the current git branch:
function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}
## this works (once parse_git_branch above has been defined) and does not have user@host, just 'host:dir(branch): '
#export PS1='\[\e[38;5;202m\]\[\e[38;5;245m\]\[\e[00m\]\[\e[38;5;172m\]\h\[\e[00m\]:\[\e[38;5;202m\]\w\[\e[38;5;245m\]$(parse_git_branch)\[\e[00m\]$ '
## this one has user@host:working/dir(branch):
export PS1='\[\e[38;5;202m\]\W\[\e[38;5;245m\]$(parse_git_branch)\[\e[00m\]$ '
# export HOMEBREW_CELLAR='/usr/local/Cellar'

