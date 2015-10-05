#
# cse-reload module
#
# add cse-reload alias - re-init CSE in current bash instance
#
# script IN :
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="1.0"

p DEBUG "load cse-reload module ${version}"

alias 'cse-reload'='. ~/.cse/include.sh'

