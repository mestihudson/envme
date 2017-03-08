#!/bin/bash
__mkdirs() {
  mkdir -p /opt/dev/{apps,bin,desktops,scripts,ws}
  mkdir -p /opt/dev/apps/{packs,links}
  mkdir -p /opt/dev/apps/packs/{eclipse,jboss,jdk,maven,node,rtc-client,tomcat}
}

__mk_jdk_links() {
  ln -s /usr/lib/jvm/java-8-openjdk-amd64 /opt/dev/apps/links/openjdk8
  ln -s /opt/dev/apps/links/openjdk8 /opt/dev/apps/links/jdk8
  ln -s /opt/dev/apps/links/jdk8 /opt/dev/apps/links/jdk
}

__md5_of() {
  filename="$1"
  md5="$2"
  output="/tmp/$filename"

  test "`md5sum \"$output\"|awk '{ print \$1 }'`" == "`cat \"$md5\"`" && echo "y" || echo "n"
}

__get() {
  url="$1"
  output="$2"

  wget -q "$url" -O "$output"
}

__version() {
  packs="$1"
  name="$2"
  version="$3"

  __rename "$packs/$name" "$packs/$version"
}

__rename() {
  old="$1"
  new="$2"

  mv "$old" "$new"
}

__ungz() {
  output="$1"
  directory="$2"

  tar xzf "$output" --directory "$directory"
}

__unxz() {
  output="$1"
  directory="$2"

  tar xJf "$output" --directory "$directory"
}

__unzip() {
  output="$1"
  directory="$2"

  unzip -qq "$output" -d "$directory"
}

__get_if_unexists() {
  url="$1"
  filename="$2"
  md5="$3"
  output="/tmp/$filename"

  (test ! -e "$output" || test "`__md5_of \"$filename\" \"$md5\"`" == "n") && __get "$url" "$output"
}

__symlink() {
  source="$1"
  target="$2"

  ln -s "$source" "$target"
}

__install_maven() {
  url="http://ftp.unicamp.br/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz"
  filename="apache-maven-3.3.9-bin.tar.gz"
  name="apache-maven-3.3.9"
  pack="maven"
  packs="`__packs $pack`"
  links="/opt/dev/apps/links"
  version="3.3.9"
  output="/tmp/$filename"
  md5="`pwd`/MD5.$filename"

  __go "$packs"
  __get_if_unexists "$url" "$filename" "$md5" && __ungz "$output" "$packs" && __version "$packs" "$name" "$version"
  __symlink "$packs/$version" "$links/maven3"
  __symlink "$links/maven3" "$links/maven"
  __back
}

__go() {
  directory="$1"

  cd "$directory"
}

__packs() {
  pack="$1"
  packs="/opt/dev/apps/packs/$pack"

  echo "$packs"
}

__back() {
  cd - 2>&1 > /dev/null
}

__install_jboss() {
  url="http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip"
  filename="wildfly-10.1.0.Final.zip"
  name="wildfly-10.1.0.Final"
  pack="jboss"
  packs="`__packs $pack`"
  links="/opt/dev/apps/links"
  version="$name"
  output="/tmp/$filename"
  md5="`pwd`/MD5.$filename"

  __go "$packs"
  __get_if_unexists "$url" "$filename" "$md5" && __unzip "$output" "$packs"
  __symlink "$packs/$version" "$links/jboss-$version"
  __symlink "$links/jboss-$version" "$links/jboss"
  __back
}

__install_node() {
  url="https://nodejs.org/dist/v7.7.1/node-v7.7.1-linux-x64.tar.xz"
  filename="node-v7.7.1-linux-x64.tar.xz"
  name="node-v7.7.1-linux-x64"
  pack="node"
  packs="`__packs $pack`"
  links="/opt/dev/apps/links"
  version="$name"
  output="/tmp/$filename"
  md5="`pwd`/MD5.$filename"

  __go "$packs"
  __get_if_unexists "$url" "$filename" "$md5" && __unxz "$output" "$packs"
  __symlink "$packs/$version" "$links/node-$version"
  __symlink "$links/node-$version" "$links/node"
  __back
}

__copy_env_files() {
  test ! -e /opt/dev/env && cp -fr env /opt/dev
}

__bind_env_all_to_bashrc() {
  user="$1"
  all="source /opt/dev/env/all"
  bashrc="$user/.bashrc"

  test -z "`cat $bashrc|grep \'$all\'`" && echo "$all" >> "$bashrc"
}
