#
# gradle module
#
# add gradle helper commands
#
# script IN :
#     p       - print alias, function
#     MOD_DIR - path to this mod dir
#

version="1.0"

p DEBUG "load gradle module ${version}"

alias 'gradle-init-java'="gradle_init_java"

# -- functions --

__MOD_DIR="$MOD_DIR"

# init gradle java project structure
#
gradle_init_java() {

  if [ "$1" = "" ]; then
    local PDIR=".";
  else
    local PDIR="./$1"
  fi

  mkdir -p ${PDIR}/src/{main,test}/{java,resources}

  local BUILD_GRADLE_FILE=$PDIR/build.gradle

  if [ -f $BUILD_GRADLE_FILE ]; then
    echo "build gradle file already exists: $BUILD_GRADLE_FILE"
    echo "overwrite? [yes/no]"
    read ANS
    if [ "$ANS" != "yes" ]; then
      p ERROR "do not override already exists build gradle file: $BUILD_GRADLE_FILE"
      return 1
    fi
    p INFO "overwrite already exists build gradle file: $BUILD_GRADLE_FILE"
  fi

  local LOGGER_ENABLED=true
  local GUAVA_ENABLED=true

  # template variables
  if [ "$LOGGER_ENABLED" = "true" ]; then
    local LOGGER_VERSION='
  log4j2Version = "2.1"
  slf4jVersion  = "1.7.5"
    '
    local LOGGER_DEPENDENCIES='
  // logging
  compile "commons-logging:commons-logging:1.1.3"
  compile "org.slf4j:jul-to-slf4j:${slf4jVersion}"
  compile "org.slf4j:slf4j-api:${slf4jVersion}"
  compile "org.apache.logging.log4j:log4j-api:${log4j2Version}"
    '
  fi

  if [ "$GUAVA_ENABLED" = "true" ]; then
    local GUAVA_VERSION='
  guavaVersion = "18.0"
    '
    local GUAVA_DEPENDENCIES='
  compile "com.google.guava:guava:${guavaVersion}"
    '
  fi

  # write build.gradle from template
  local TEMPLATE=`cat "$__MOD_DIR/build.gradle.template"`
  eval "echo \"${TEMPLATE}\"" > ${BUILD_GRADLE_FILE}

}

