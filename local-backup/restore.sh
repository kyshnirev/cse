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

set -e
set -u

[ "$1" == "" ] && { echo "ERROR: missing param <file_name>"; exit 1; }
[ -f "$1" ] || { echo "ERROR: file does not exists: '$1'"; exit 1; }

# load config
. "$( dirname $0 )/config"

FPATH="$(readlink -e $1)"
FNAME="${FPATH##*/}"
FDIR="${FPATH%/*}"


PTF="${BAK_DIR}${FDIR}"
#
# example: /home/user/bak/home/user/.cse/local-backup/bak.sh:2014-09-18_12-31
echo "INFO: search for '$FNAME' in '$PTF'"

I=1
INDEXES="$I"
echo "[$I] cancel"
while read ITEM # do not using sub-shell ( pass data to loop at end '<<< find ...' )
do
  if [ -z "$ITEM" ]; then
    continue
  fi
  I=$(( $I + 1 ))
  INDEXES="$INDEXES $I"
  echo "[$I] $ITEM"
done <<< "$( find "$PTF" -name "$FNAME*" | sed -nr 's|.*/([^/]+):([^_]+)_(.*)$|\1   /   \2 \3|p' )"

AND=''
while [ -z "${ANS:-}" ];
do
  read -p 'Select file version: ' ANS

  # check input
  case "$INDEXES" in
    *$ANS*)
      echo "your input: $ANS"
      ;;
    *)
      echo "ERROR: wrong input: '$ANS', available: '$INDEXES'"
      ANS=''
      ;;
  esac
done

# cancel
if [ "$ANS" = "1" ]; then
  echo 'canceled'
  exit 0
fi

# get selected file absolute path
SELFILE=$( find "$PTF" -name "$FNAME*" | sed -n "${ANS}p" )
echo "you select: $SELFILE"

if ! [ -f "$SELFILE" ]; then
  echo "ERROR: file not exists '$SELFILE'"
  exit 2
fi

cp_print() {
  if [ -f "$2" ]; then
    echo "save $2 to $BAK_DIR/last-replaced"
    cp "$DEST_WT" "$BAK_DIR/last-replaced" # bacup last replaced file
  fi
  echo "COPY $1 TO $2"
  cp "$1" "$2"
}

# process file
PS3='Select file operation: '
select OPT in cancel copy replace
do
  case $OPT in
  cancel)
    echo "canceled"
    exit 0
    ;;
  copy)
    DEST="${SELFILE#$BAK_DIR}" # remove bak dir prefix from full path
    cp_print "$SELFILE" "$DEST"
    ;;
  replace)
    DEST="${SELFILE#$BAK_DIR}" # remove bak dir prefix from full path
    DEST_WT=${DEST%:*} # remove all after ':'
    cp_print "$SELFILE" "$DEST_WT"
    ;;
  *)
    echo "ERROR: unknown file operation '$OPT'"
    exit 3
    ;;
  esac
  break # select
done

