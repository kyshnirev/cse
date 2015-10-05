#!/bin/bash

#
# locak file backup
#
# using:
#     bak file_name
#
# copy file_name into ~/bak folder and add timestamp to name
# later you can retore in with restore.sh
#
# sept 2014, GK
#

if [ "$1" == "" ]; then
  echo "missing argumen <filename>"
  exit 1
fi


if ! [ -f "$1" ]; then
  echo "file does not exists: '$1'"
  exit 1
fi

FILE=`readlink -f "$1"`
FILEDIR=`dirname $FILE`
BAKDIR=~/bak

DESTDIR="${BAKDIR}${FILEDIR}"
DESTFILE="${BAKDIR}${FILE}:`date +%Y-%m-%d_%H-%M`"

mkdir -p "$DESTDIR"
cp "$FILE" "$DESTFILE"

echo "backup to: $DESTFILE"

