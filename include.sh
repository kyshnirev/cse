#
# Common Scripts Extension, include.sh
#
# to enable Common Script Extension modules
# include this into you ~/.bashrc :
#
#     ~/.bashrc
#         . ~/.cse/include.sh
#
# oct 2014, GK
#

# note: not works for symbolik links
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


#
# if true - print log into sdout, and may be some more
# ******************************************
DEV_MODE=false
# ******************************************
#

#
# print alias, LOG
# ******************************************
LOG_FILE=$BASEDIR/startup.log
# init log
echo "CSE startup at `date`" > $LOG_FILE
#
function p() {
  [ "$2" = "" ] && local LEVEL="DEF" || local LEVEL="$1"
  local MSG="[$LEVEL] $( caller ) - ${2:-$1}"

  if [ "$LEVEL" == ERROR ] || [ "$DEV_MODE" = true ]; then
    echo $MSG
  fi
  echo $MSG >> $LOG_FILE
}
# ******************************************
#


#
# arguments
# ******************************************
if [ "$1" = "--debug" ] || [ "$1" = "DEBUG" ]; then
  DEV_MODE=true
  p DEBUG "$1 : DEV_MODE enabled"
fi
# ******************************************
#


#
# search and load modules
# ******************************************
for MOD in $( ls "$BASEDIR" ); do
  MOD_DIR="$BASEDIR/$MOD"

  # module must be in own dir, and contains module.sh

  if [ -d "$MOD_DIR" ] && [ -f "$MOD_DIR/module.sh" ]; then
    p INFO "found module $MOD in $MOD_DIR"

    . "$MOD_DIR/module.sh" # load module

  fi
done
# ******************************************
#

