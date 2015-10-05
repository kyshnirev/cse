#
# trim-file module
#
# remove any space characters from each line end
#
# using:
#     trim my_file.txt
#
# script in:
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#
# oct 2014, GK
#

version="1.0"

p DEBUG "load trim-file module ${version}"

function trim() {
  local FNAME="$1"
  if ! [ -f $FNAME ]; then
    echo "missing argument, or file not exists: '$FNAME'"
    return
  fi

  local BAK="$2"

  echo "start trim trailing spaces in file '$FNAME'"

  if [ "$BAK" = "-b" ] || [ "$BAK" = "--bak" ]; then
    sed -i.bak 's/[[:space:]]*$//g' "$FNAME"
  else
    sed -i 's/[[:space:]]*$//g' "$FNAME"
  fi

  echo "done."
}

