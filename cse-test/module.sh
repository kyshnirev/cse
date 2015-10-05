#
# cse-test module
#
# add cse-test alias - to check CSE is works
#
# script IN :
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="1.0"

p DEBUG "load test module ${version}"

TEST_MSG="':: CSE test module version : ${version} ::'"
alias 'cse-test'="echo $TEST_MSG"

