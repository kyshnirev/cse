#
# local backup module
#
# add aliases to backup and restore some file
# backup copies stored in ~/bak dir, with timestamp (multiply copies possible)
#
# examples:
#     $ bak                         - show help
#     $ bak <file_name>             - make one file backup
#     $ bak restore <file_name>     - restore backuped file
#
#
# script in:
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="0.1"

p INFO "load local-bakup module ${version}"

# make alias to main control file
alias bak="$MOD_DIR/bak.sh"

