#Install for Later

Handy script to install a package and make a note of it for later when you have time to actually do something with it.

It creates and updates a log file (by default ~/documents/new-pkgs.txt; change the config variable if you want it somewhere else) so you can look up what that nifty package was that you installed the other day but can't recall the name of. It will also remind you what was included in a package if you try to run it for something that's already installed.

##Notes
currently designed only for systems that use apt-get.

##Sample log file contents:

    Package: orage
    Sat May 16 22:50:19 CDT 2015
    ============================
    Description-en: Calendar for Xfce Desktop Environment
    Binaries:
    /usr/bin/orage
    /usr/bin/tz_convert
    /usr/bin/globaltime
