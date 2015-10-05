#!/bin/bash

#
# restore file into current dir, bakuped by bak.sh
#
# using:
#     restore.sh file_name
#
# find file_name into bak folder, if found - show menu with varianst
# select variant number and look for restored version (ls -l)
#
# sept 2014, GK
#

FNAME="$1"

if [ "$FNAME" == "" ]; then
  echo "ERROR: missing param <file_name>"
  exit 1
fi

echo "INFO: search for '$FNAME'"

BAKDIR=~/bak

FILES=()
#
# example: /home/user/bak/home/user/.cse/local-backup/bak.sh:2014-09-18_12-31
for LINE in `find $BAKDIR -name "$FNAME*"` ; do
  # extract filename:date
  T=`echo "$LINE" | sed -n "s|.*/\([^/]\+:.*\)$|\1|p"`
  FILES=( ${FILES[*]} $T )
done

echo "INFO: ${FILES[*]} founded"

SELFILE=''
PS3='Select file version: '
select OPT in ${FILES[*]} 'cancel'
do

  if [ "$OPT" == 'cancel' ]; then
    echo "INFO: cancel"
    exit 0
  fi

  SELFILE="$OPT"
  break

done
echo "you select: $SELFILE"

FP=`find $BAKDIR -name "$SELFILE"`

echo "DEBUG: FP=$FP"

cp $FP ./$SELFILE

