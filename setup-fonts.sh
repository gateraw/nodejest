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

FONTPATCHER_DIR=$HOME/src/fontpatcher
if [ -d $FONTPATCHER_DIR ]; then
	(cd $FONTPATCHER_DIR; git pull --rebase)
else
	mkdir -p $HOME/src
	git clone https://github.com/powerline/fontpatcher.git $FONTPATCHER_DIR
	cd $FONTPATCHER_DIR
	git am $TOPDIR/fontpatcher-py3.patch
	./setup.py build
fi
FONTPATCHER=$FONTPATCHER_DIR/scripts/powerline-fontpatcher

# Setup Courier-Prime.ttf - http://quoteunquoteapps.com/courierprime
cd $TMPDIR
curl -L -O https://quoteunquoteapps.com/courierprime/downloads/courier-prime.zip
unzip -