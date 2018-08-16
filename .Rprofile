options(repos = c(CRAN="https://cran.r-project.org"))
options(unitizer.state='recommended')
options(menu.graphics=FALSE)
di <- function(x = ".") {
  dirname <- basename(normalizePath(x))
  if(
    inherits(
      try(
        detach(sprintf("package:%s", dirname), unload=TRUE, character.only=TRUE)
      ), "try-error"
  ) )
    warning("Unable to unload package; it may not be loaded.")
  install.packages(repos=NULL, normalizePath(x), type="src")
  library(dirname, character.only=TRUE)
}
dd <- devtools::document
cd <- function(x=.Last.value) {
  dep.val <- deparse(x, width=500)
  overflow:::writeClip(dep.val)
  cat(dep.val, "\n", sep="")
}

dataStr <- function(fun=function(x) TRUE)
  str(
    Filter(
      fun,
      Filter(
        Negate(is.null),
        mget(data()$results[, "Item"], inh=T, ifn=list(NULL))
) ) )

# options(diffobj.brightness=c("neutral", ansi256="dark"))

options(unitizer.state='recommended')

wre <- function() browseURL(file.path(R.home("doc"), 'manual', 'R-exts.html'))

check_cran <- function(email) {
  utils::browseURL(
    sprintf(
      "https://cran.r-project.org/web/checks/check_results_%s.html",
      gsub("[^A-Za-z0-9_:.-]", "_", sub("@", "_at_", email))
) ) }
if(interactive()) check_cran('brodie.gaslam@yahoo.com')
