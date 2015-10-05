#
# cd-up module
#
# add cd.. alias
#
# examples:
#
#     - cd up to dir
#         $ cd /home/user/documents/reposrt/2014-10-01
#         $ cd.. doc
#         > cd to '/home/user/document'
#
#     - cd up to N dirs
#         $ cd /home/user/documents/reposrt/2014-10-01
#         $ cd.. 3
#         > cd to '../../../'
#     - cd up to one dir
#         $ cd /home/user/documents/reposrt/2014-10-01
#         $ cd..
#         > cd to '../'
#
#
# script in:
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#
# oct 2014, GK
#

version="1.0"

p DEBUG "load cd-up module ${version}"


# cd up to n dirs
# using:  cd.. 10   cd.. dir
function cd_up() {
  case $1 in
    *[!0-9]*)                                          # if no a number
      cd $( pwd | sed -r "s|(.*/$1[^/]*/).*|\1|" )     # search dir_name in current path, if found - cd to it
      ;;                                               # if not found - not cd
    *)
      cd $(printf "%0.0s../" $(seq 1 $1));             # cd ../../../../  (N dirs)
    ;;
  esac
}

alias 'cd..'='cd_up'  # one param expected

