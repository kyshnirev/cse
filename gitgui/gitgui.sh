#!/bin/sh

# run
#   git gui
#   gitk --all
# for current dir (git repo)
#
# jan 2014, GK 
#

[ "$1" = "" ] && DIR=`pwd` || DIR="$1"

if [ ! -d "$DIR/.git" ]
then
  echo "No git repository hear ($DIR)"
  exit 1  
fi

git gui &
gitk --all &

