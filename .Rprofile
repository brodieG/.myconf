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

check_cran <- function(
  email, cache='~/.R-cran-status.RDS', cache.life=24 * 3600
) {
  display_check <- function(x, extra=NULL) {
    print(x)
    err.cols <- x[names(x) %in% c("WARNING", "ERROR")]
    if(sum(as.numeric(err.cols), na.rm=TRUE))
      writeLines(c("\033[41mErrors/Warnings Present\033[m", url))
    writeLines(c(extra, ""))
  }
  renew.cache <- TRUE
  if(file.exists(cache)) {
    cache.dat <- readRDS(cache)
    cache.age <- Sys.time() - cache.dat[[1]]
    if(as.double(cache.age, 'secs') < cache.life) {
      renew.cache <- FALSE
      display_check(
        cache.dat[[2]],
        c("",
          sprintf(
            "cached CRAN status (%s old).", format(round(cache.age))
  ) ) ) } }
  if(renew.cache) {
    url <- sprintf(
      "https://cran.r-project.org/web/checks/check_results_%s.html",
      gsub("[^A-Za-z0-9_:.-]", "_", sub("@", "_at_", email))
    )
    cat("connecting to CRAN...")
    page <- readLines(url)
    cat("\r                     \r")
    pattern <- "\\s*<t[hd].*?>(.*?)</t[hd]>"
    has.rows <- grep(pattern, page, perl=TRUE)
    strings <- gregexpr(pattern, page[has.rows], perl=TRUE)
    res <- sapply(
      regmatches(page[has.rows], strings),
      function(x) {
        submatch <- regexec(pattern, x, perl=TRUE)
        vapply(regmatches(x, submatch), "[[", character(1L), 2)
      }
    )
    res.mx <- t(gsub("<[^>]*>|^\\s+|\\s+$", "", res))
    res.mx.2 <- res.mx[-1, ]
    colnames(res.mx.2) <- res.mx[1, ]
    res.df <- as.data.frame(res.mx.2, stringsAsFactors=FALSE)
    saveRDS(list(Sys.time(), res.df), cache)
    display_check(res.df)
  }
}
if(interactive()) check_cran('brodie.gaslam@yahoo.com')
