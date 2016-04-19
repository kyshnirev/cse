#!/bin/bash

#
# puburl module
#
# take dropbox public url for file in Dropbox/Public/ folder
#
# using:
#     puburl file-name.png
#     puburl file // find by part of name
#
# script in:
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#
# apr 2016, GK
#

if [ "$0" != '/bin/bash' ]; then
  p ERROR "shell: $0"
  return 1 # do not use 'exit', module script load with 'source' command
fi

version="1.0"

p DEBUG "load puburl module ${version}"

function __puburl_fn() {
  local FNAME="$1"
  if [ -z $FNAME ]; then
    echo "missing argument"
    return
  fi

  local DROPBOX_PUB_DIR=~/Dropbox/Public

  local FILES=( $(find $DROPBOX_PUB_DIR -name "*$FNAME*" | head) )
  if [ "${#FILES[@]}" = 0 ]; then
    echo "not found '$FNAME' in $DROPBOX_PUB_DIR"
    return
  fi

  local SEL_FILE=''
  if [ "${#FILES[@]}" = 1 ]; then
    SEL_FILE="${FILES[0]}"
  else
    PS3='select file:'
    select SEL_FILE in 'Cancel' "${FILES[@]}"; do
      case "$SEL_FILE" in
        Cancel) return ;;
        *) break ;;
      esac
    done
  fi

  dropbox puburl "$SEL_FILE"
}

alias puburl='__puburl_fn'

