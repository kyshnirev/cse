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
# if $(dirname $0) == "/bin" - it is bash initialization, else - manual run
# ******************************************
[ "$( dirname $0 )" == "/bin" ] && DEV_MODE=false || DEV_MODE=true
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
    local MSG="[$1] $( caller ) - $2"
  fi
  [ "$DEV_MODE" == "true" ] && echo $MSG
  echo $MSG >> $LOG_FILE
}
# ******************************************
#


#
# search and load modules
# ******************************************
for MOD in $( ls ); do
  MOD_DIR="$BASEDIR/$MOD"

  # module must be in own dir, and contains module.sh

  if [ -d "$MOD_DIR" ] && [ -f "$MOD_DIR/module.sh" ]; then
    p INFO "found module $MOD in $MOD_DIR"

    . "$MOD_DIR/module.sh" # load module

  fi
done
# ******************************************
#

