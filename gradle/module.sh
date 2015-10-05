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

# init gradle java project structure
#
gradle_init_java() {

  if [ "$1" = "" ]; then
    local PDIR=".";
  else
    local PDIR="./$1"
  fi

  mkdir -p "${PDIR}/src/{main,test}/{java,resources}"

  echo '# gradle build script

apply plugin: "java"

ext {
  log4j2Version = "2.1"
  slf4jVersion = "1.7.5"
  guavaVersion = "18.0"
}


repositories {
  mavenCentral()
}

dependencies {
  // test
  testCompile "junit:junit:4.4"

  // logging
  compile "commons-logging:commons-logging:1.1.3"
  compile "org.slf4j:jul-to-slf4j:${slf4jVersion}"
  compile "org.slf4j:slf4j-api:${slf4jVersion}"
  compile "org.apache.logging.log4j:log4j-api:${log4j2Version}"

}

  ' > $PDIR/build.gralde

}

