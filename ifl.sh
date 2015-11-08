#! /bin/bash
# Handy script to install a package and make a note of it for later when
# you have time to actually do something with it.
# --Sam Walker 2015/5/16
# --2015/7/19: Now tries to be more helpful in listing to the terminal
#      the installed files from dpkg -L if you specify something already
#      installed.
# --2015/11/7: Cleaned up formatting and added a bit of verbosity to the
#      successful install output.

package=$1
packagelog="$HOME/documents/new-pkgs.txt"

if [[ -z $package ]]; then
    echo >&2 "You must supply a package name to install. Exiting."
    exit 1
fi    

if ! $(command -v apt-get >& /dev/null); then
     echo >&2 "Sorry, $0 is only designed for debian-likes which use apt-get. \
         Exiting."
     exit 1
fi

dpkg -s $package >& /dev/null

if [[ $? != 0 ]]; then
    # if apt-get exits non-zero it probably didn't install anything.
    # we'll let the user deal with it and not write to the logfile.
    sudo apt-get install $package || exit $?

    # Append install entry to the log file
    apt-cache show $package | grep ^Package >> $packagelog
    date >> $packagelog
    echo "============================" >> $packagelog
    apt-cache show $package | grep ^Description-en >> $packagelog
    echo "Binaries:" >> $packagelog
    dpkg -L $package | grep bin >> $packagelog
    echo "" >> $packagelog

    # Print message to stdout to verify the install was logged.
    echo ""
    echo "============================"
    echo ""
    echo "Succesfully installed $package and added entry to the log at \
        $packagelog."
    echo ""
    echo "Included binaries:"
    echo ""
    echo dpkg -L $package | grep bin
else
    # Remind the user what the package contains if they try to install it
    # again, because the probably forgot about it!
    echo >&2 "$package is already installed. It affects the files below:"
    sleep 2
    echo ""
    echo "Binaries:"
    echo ""
    dpkg -L $package | grep bin
    echo ""
    echo "Other files:"
    echo ""
    dpkg -L $package | grep -v bin
    exit 1    
fi
