#
# share module
#
# add share alias - to share 
#
# script IN :
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="1.0"

alias 'share'="share_on_dropbox_public_fn"

share_on_dropbox_public_fn() {

  local DIR=~/Dropbox/Public/share
  [ -d "$DIR" ] || mkdir -p "$DIR";

  [ -d "$DIR" ] || ( p ERROR "is not a dir: ${DIR}"; return 1; )

  # process arguments

  if [ "$1" = 'clean' ]; then 
    echo "clean $DIR ? (`ls -1 $DIR | wc -l` files) [y/n]"
    read __ANS
    if ! [ "$__ANS" = 'y' ]; then
      echo "clean canceled"
    else
      echo "delete all files from $DIR" 
      rm ${DIR}/*
    fi
    return 0
  fi

  local FILE="$1"
  [ -f "$FILE" ] || ( p ERROR "file not exists: $FILE"; return 2; )

  # share file on Drobpox

  local TARGET="${DIR}/${FILE##*/}"
  if [ -f "$TARGET" ]; then
    local FNAME="${FILE##*/}"
    local TARGET="${DIR}/`date +%s`.${FNAME}"
    echo "shared file ${FNAME} already exists, create new: ${TARGET}"
  fi

  cp "$FILE" "$TARGET"
  dropbox puburl "$TARGET"

}

