#
# cse-update module
#
# add cse-update alias - to download and install CSE updates
#
# script IN :
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="1.0"

alias 'cse-update'='cse_update'

__MOD_DIR="$MOD_DIR"
__BASE_DIR="$BASEDIR"

cse_update() {
  local URL='https://github.com/kyshnirev/cse/archive/master.zip'
  local TMP_FILE="/tmp/cse-master.zip"

  wget $URL -O "$TMP_FILE"
  [ "$?" != "0" ] && ( p ERROR "failed to download $URL to $TMP_FILE"; exit 1 )

  [ -f "$TMP_FILE" ] || ( p ERROR "file not exists: $TMP_FILE"; exit 2 )

  [ "${__BASE_DIR##*/}" = ".cse" ] || ( p ERROR "BASEDIR=$__BASE_DIR is not ends with '.cse'"; exit 3 )
  #mv "${__BASE_DIR}" "${__BASE_DIR}-bak-$( date +%Y%d%m-%H%M%S )"

  tar -P -czf "${__BASE_DIR}.`date +%Y%d%m-%H%M%S`.tgz" "${__BASE_DIR}"

  rm -rf "${__BASE_DIR}" && mkdir "${__BASE_DIR}"
  [ -d "${__BASE_DIR}/cse-reload" ] && ( p ERROR "not-clean"; exit 4 )

  unzip "$TMP_FILE" -d "$__BASE_DIR"
  mv $__BASE_DIR/cse-master/* $__BASE_DIR

  #p INFO "updated"
}

