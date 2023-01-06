# Building R on Windows

## Overview

We have both git bash and Rtools bash (and a few MinGW).  Use gitbash for git.

## References

* https://github.com/r-windows/
* https://cran.r-project.org/bin/windows/Rtools/
* https://github.com/r-windows/r-base#readme

## Rtools 4.2

Detailed instructions (see "Building R from source using Rtools42" section):

https://svn.r-project.org/R-dev-web/trunk/WindowsBuilds/winutf8/ucrt3/howto.html

Careful to stay in the single section.  There are similar passages in different
sections so it's easy to end up accidentally running the wrong commands.

There is a slightly confusing comment:

> Set environment variables as follows (update MiKTeX installation directory in
> the commands below if needed, this one is “non-standard” from an automated
> installation described later below):

AFAICT that the specified directory:

    export PATH=/c/Program\ Files/MiKTeX/miktex/bin/x64:$PATH

Is the standard one, or at least that's where my prior install had been.

## r-base

At some point during transition to UCRT this started failing so we moved to the
above.

Use R-tools bash.

Installation will require miktek, make sure to install for "all users" so the
install can be found.

Things to modify:

* quick-build.sh so it doesn't nuke the R directory every time
* Mkrules.local.in (this is in r-base, not in the sources):
    * DEBUG = TRUE
    * EOPTS = -O0          << and any other CFLAGS!
    * no recommended?

The rtools bashes have their own root structure.

Files are:

* On Workspaces D:\Users\milberg\Documents (i.e. ~/Documents from rtools40 MSYS).
* On Home PC they are at C:\rtools40\home

## Pacman

Use Rtools Bash.  Seems to only have the mingw repos set-up by default, so not
all common software is there.  The gitbash thing has more?

For rtools, go to '/etc/pacman.conf' and enable the 'msys' repository to get
more stuff, but watch out it could mess everything up!

Tried doing this to get subversion but I kept getting asked to add a key that I
could not verify corresponding to anyone trusted, so I gave up and went to
tortoise.

## Subversion

Can use tortoise, haven't figured out how to use it from command line.

SVN cleanup unversioned files does not work for .o, .a?  Use:

    cd src/gnuwin32
    make distclean

## ssh-agent

git bash has it, but use:

    eval $(ssh-agent -s)

The other options in [1] didn't seem to work.  It's possible it had to be a mix
of all of these to get it to work.  Actually worked after doing this last one.

## Windows VM

[Blog Post][2] and [instructions][3].

In theory can re-use the file we keep in ~/../Shared/vagrant/win10-tst.

Edit Vagrantfile to change id_rsa to the right one.  Also, probably change
v.cpus and v.memory.

Remember to reset path each time on startup:

    which cc1 gcc pdflatex

What to copy paste (extracted from blog post):

```
vagrant ssh
# vagrant rdp -- /cert-ignore
set MSYSTEM=MSYSTEM & "c:\msys64\usr\bin\bash.exe" --login -i

export PATH=`pwd`/x86_64-w64-mingw32.static.posix/bin:$PATH
export PATH=`pwd`/x86_64-w64-mingw32.static.posix/libexec/gcc/x86_64-w64-mingw32.static.posix/10.2.0:$PATH
export PATH=/c/Program\ Files/MiKTeX/miktex/bin/x64:$PATH
export TAR="/usr/bin/tar --force-local"

cd trunk
svn cleanup --remove-unversioned
unzip ../Tcl.zip

cd src/gnuwin32
cat <<EOF >MkRules.local
LOCAL_SOFT = `pwd`/../../../x86_64-w64-mingw32.static.posix
WIN = 64
BINPREF64 =
BINPREF =
USE_ICU = YES
ICU_LIBS = -lsicuin -lsicuuc \$(LOCAL_SOFT)/lib/sicudt.a -lstdc++
USE_LIBCURL = YES
CURL_LIBS = -lcurl -lzstd -lrtmp -lssl -lssh2 -lgcrypt -lcrypto -lgdi32 -lz -lws2_32 -lgdi32 -lcrypt32 -lidn2 -lunistring -liconv -lgpg-error -lwldap32 -lwinmm
USE_CAIRO = YES
CAIRO_LIBS = "-lcairo -lfontconfig -lfreetype -lpng -lpixman-1 -lexpat -lharfbuzz -lbz2 -lintl -lz -liconv -lgdi32 -lmsimg32"
CAIRO_CPPFLAGS = "-I\$(LOCAL_SOFT)/include/cairo"
TEXI2ANY = texi2any
MAKEINFO = texi2any
ISDIR = C:/Program Files (x86)/InnoSetup
EOF

make rsync-recommended
make all 2>&1 | tee make.out
## make all recommended 2>&1 | tee make.out
```

Kept getting timeouts using `vagrant ssh + MSYS`.

    Connection to 127.0.0.1 closed by remote host.
    Connection to 127.0.0.1 closed.

Tried:

    winrm set winrm/config @{MaxTimeoutms ="180000000"}

Check memory use around time of failure but there was plenty of RAM (not sure at
exact time of failure).  Also saw failures happening when idle, which strongly
suggests a timeout.  Seems to be working with RDC, and even in the non MSYS
shell.  Maybe MSYS just doesn't report back activity?


[1]: https://stackoverflow.com/a/18683544
[2]: https://developer.r-project.org/Blog/public/2021/03/18/virtual-windows-machine-for-checking-r-packages/
[3]: https://svn.r-project.org/R-dev-web/trunk/WindowsBuilds/winutf8/ucrt3/vm.html

