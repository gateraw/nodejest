#!/bin/sh
# Assumes running on Ubuntu.

set -e -u

TOPDIR=`cd $(dirname $0); pwd`
TMPDIR=$TOPDIR/tmp
FONTDIR=$TOPDIR/app/src/main/assets/fonts/

rm -Rf $TMPDIR
mkdir -p $TMPDIR

# Install python fontforge bindings for use by powerline font patcher:
if [ $(dpkg-query -W -f='${Status}' python3-fontforge 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
	sudo apt install python3-fontforge
fi

FONTPATCHER_DIR=$HOME/src