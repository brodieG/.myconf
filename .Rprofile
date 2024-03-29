if(interactive()) {
  options(
    repos=c(CRAN="https://cran.r-project.org"),
    unitizer.state='recommended',
    deparse.max.lines=1,
    menu.graphics=FALSE,
    help_type='html',
    warnPartialMatchArgs=TRUE,
    warnPartialMatchAttr=TRUE,
    warnPartialMatchDollar=TRUE,
    blogdown.ext='.Rmd',
    blogdown.method='html',
    blogdown.hugo.version = "0.118.2",
    blogdown.hugo.server = c('-D', '-F', '--disableLiveReload'),
    blogdown.new_bundle = TRUE
  )
  di <- function(x = ".", full=TRUE, tests=FALSE) {
    x <- normalizePath(x)
    dirname <- basename(x)
    pkg <- sprintf("package:%s", dirname)
    det <- try(detach(pkg, unload=TRUE, character.only=TRUE))
    iopts <- c(
      if(!full)
        c(
          "--no-byte-compile", "--no-docs", "--no-help", "--no-html",
          "--no-lock", "--no-test-load"
        ),
      if(tests) "--install-tests"
    )
    install.packages(repos=NULL, x, type="src", INSTALL_opts=iopts)
    library(dirname, character.only=TRUE)
  }
  di0 <- function(x = '.') di(x, full=FALSE)

  rr <- function(...) roxygen2::roxygenize(...)

  maxchr <- function(x) {
    maxchr <- max(as.integer(charToRaw(x)))
    stopifnot(maxchr < 127)
    maxchr
  }
  # cd <- function(x=.Last.value) {
  #   dep.val <- deparse(x, width=500)
  #   overflow:::writeClip(dep.val)
  #   cat(dep.val, "\n", sep="")
  # }

  dataStr <- function(fun=function(x) TRUE)
    str(
      Filter(
        fun,
        Filter(
          Negate(is.null),
          mget(data()$results[, "Item"], inh=T, ifn=list(NULL))
  ) ) )

  # options(diffobj.brightness=c("neutral", ansi256="dark"))

  check_cran <- function(
    email, cache='~/.R-cran-status.RDS', cache.life=24 * 3600
  ) {
    url <- sprintf(
      "https://cran.r-project.org/web/checks/check_results_%s.html",
      gsub("[^A-Za-z0-9_:.-]", "_", sub("@", "_at_", email))
    )
    display_check <- function(x, extra=NULL) {
      print(x)
      err.cols <- unlist(x[names(x) %in% c("WARNING", "ERROR")])
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
  check_cran('brodie.gaslam@yahoo.com', cache.life=8 * 3600)
}

Sys.setenv(NOT_CRAN='true', '_R_CHECK_LENGTH_1_LOGIC2_'='TRUE')
