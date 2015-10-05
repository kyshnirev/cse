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

  echo "start trim trailing spaces in file '$FNAME'"

  sed -i.bak 's/[[:space:]]*$//g' "$FNAME"

  echo "done."
}

