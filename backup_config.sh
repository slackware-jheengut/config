#!/bin/sh
# Copyright (c) 2012 Niki Kovacs <info@microlinux.fr>
# -----------------------------------------------------------------------------
#
# This script makes a backup of all the systems' relevant configuration files.


CWD=`pwd`

FILES=$(egrep -v '(^\#)|(^\s+$)' $CWD/files)

NETWORK=$(hostname --domain)
MACHINE="$(hostname)"
BACKUPDIR=$CWD/$NETWORK/$MACHINE

if [ ! -d $BACKUPDIR ]; then
  mkdir -p $BACKUPDIR
fi

for FILE in $FILES; do
	if [ -r $FILE ]; then
	  BASENAME=$(basename $FILE)
	  ABSPATH=$(dirname $FILE)
	  RELPATH=$(echo $ABSPATH | cut -c2- )
		if [ ! -d $BACKUPDIR/$RELPATH ]; then
		  mkdir -p $BACKUPDIR/$RELPATH
		fi
		echo ":: Backing up $FILE."
	  cp -af $FILE $BACKUPDIR/$RELPATH/	
  else
    echo ":: $FILE not found on this machine."
  fi
done

exit 1
