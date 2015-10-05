#
# tohtml module
#
# add tohtml alias - using vim current color theme to create <file-name>.html file
#
# script IN :
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="1.0"


alias 'tohtml'="to_html_fn"

to_html_fn() {

  if ! [ -f "$1" ]; then
    p ERROR "file not exists: $1"
    return 1
  fi

  vim -f +"TOhtml" +"save ${1}.html" +"q" +"q" $1

}

