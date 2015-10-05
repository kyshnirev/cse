#
# test module
#
# add test-cse alias - to check CSE is works
#
# script in:
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="1.0"

p DEBUG "load test module ${version}"

TEST_MSG="':: CSE test module version : ${version} ::'"
alias 'test-cse'="echo $TEST_MSG"

