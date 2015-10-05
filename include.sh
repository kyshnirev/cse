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
  if [ -z "$2" ]; then
    local MSG="$( caller ) $1" # $( caller ) - invoker script name and line
  else
    local MSG="[$1] $( caller ) - $2" # [log_level] caller - message
  fi
  [ $DEV_MODE != false ] && echo $MSG
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

