#
# local backup module
#
# add aliases to backup and restore some file
# backup copies stored in ~/bak dir, with timestamp (multiply copies possible)
#
# examples:
#     $ bak file_name
#     $ restore file_name
#
# script in:
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="0.1"

p INFO "load local-bakup module ${version}"

alias bak="$MOD_DIR/bak.sh"
alias restore="$MOD_DIR/restore.sh"

