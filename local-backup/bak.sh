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

# exit if commands failed
set -e
# failed on use undefined variables
set -u

# check config exits
[ -f "$( dirname $0 )/config" ] || { echo "ERROR: config missing, see: $( dirname $0 )/config.sample"; exit 30; }

HELP='
usage example:
  bak, bak -h          - show this help
  bak <file>           - backup one file
  bak restore <file>
  bak -r <file         - restore one backuped file
'
# TODO:
#   bak restore          - show file to restore choose dialog
#   bak list             - list all bacuped file from current directory
#   bak info, bak size   - show backup storage size
#

[ -z "$1" ] && { echo "ERROR: missing argument $HELP"; exit 1; }

# parse arguments
CMD=''
case "$1" in
  -h|--help)
      echo "$HELP"
      exit 0
      ;;
  -r|restore)
      FILE="$2"   # bak restore <file>
      CMD="$( dirname $0 )/restore.sh"
      ;;
  -b|backup)
      FILE="$2"  # bak backup <file>
      CMD="$( dirname $0 )/backup.sh"
      ;;
  *)
      if [ -f "$1" ]; then
        FILE="$1"   # bak <file>
        CMD="$( dirname $0 )/backup.sh"
      else
        echo "ERROR: can not backup, file does not exists: $1"
        exit 1
      fi
      ;;
esac
[ "$CMD" = '' ] && { echo "ERROR: command is empty"; exit 40; }

$CMD "$FILE"
RES="$?"

if [ "$RES" != 0 ]; then
  echo "$CMD failed, res: $RES"
  exit $RES
fi

exit 0

