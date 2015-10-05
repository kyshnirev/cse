#!/bin/bash

# copy $FILE to $BAK_DIR with date-time info

# check arguments
[ -f "$1" ] || { echo "ERROR: file no exists: $1"; exit 1; }

# load config
. "$( dirname $0 )/config"

FILE=$( readlink -f "$1" )
FILE_DIR=$( dirname $FILE )

DEST_DIR="${BAK_DIR}${FILE_DIR}"
DEST_FILE="${BAK_DIR}${FILE}:$( date +%Y-%m-%d_%H-%M )"

[ -d "$DEST_DIR" ] || mkdir -p "$DEST_DIR"

cp "$FILE" "$DEST_FILE"

echo "backup to: $DEST_FILE"

