#!/bin/bash
__mkdirs() {
  mkdir -p /opt/dev
  mkdir -p /opt/dev/apps

  mkdir -p /opt/dev/bin
  mkdir -p /opt/dev/desktops
  mkdir -p /opt/dev/scripts
  mkdir -p /opt/dev/ws

  mkdir -p /opt/dev/apps/links
  mkdir -p /opt/dev/apps/packs

  mkdir -p /opt/dev/apps/packs/eclipse
  mkdir -p /opt/dev/apps/packs/jboss
  mkdir -p /opt/dev/apps/packs/jdk
  mkdir -p /opt/dev/apps/packs/maven
  mkdir -p /opt/dev/apps/packs/node
  mkdir -p /opt/dev/apps/packs/rtc-client
  mkdir -p /opt/dev/apps/packs/tomcat

  tree /opt
}

__mk_jdk_links() {
  ln -s /usr/lib/jvm/java-8-openjdk-amd64 /opt/dev/apps/links/openjdk8
  ln -s /opt/dev/apps/links/openjdk8 /opt/dev/apps/links/jdk8
  ln -s /opt/dev/apps/links/jdk8 /opt/dev/apps/links/jdk
}

__md5_of() {
  filename="$1"
  output="/tmp/$filename"

  test "`md5sum '$filename'|awk '{ print \$1 }'`" == "`cat 'MD5.$filename'`" && echo "y" || echo "n"
}

__get() {
  url="$1"
  output="$2"

  wget "$url" -O "$output"
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

  tar xvzf "$output" --directory "$directory"
}

__unzip() {
  output="$1"
  directory="$2"

  unzip "$output" -d "$directory"
}

__get_if_unexists() {
  url="$1"
  filename="$2"
  output="/tmp/$filename"

  (test ! -e "$output" || test "y" == "`__md5_of '$filename'`") && __get "$url" "$output"
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
  packs="/opt/dev/apps/packs/maven"
  links="/opt/dev/apps/links"
  version="3.3.9"
  output="/tmp/$filename"

  cd "$packs"
  __get_if_unexists "$url" "$filename" && __ungz "$output" "$packs" && __version "$packs" "$name" "$version"
  __symlink "$packs/$version" "$links/maven3"
  __symlink "$links/maven3" "$links/maven"
  cd -
}

__install_jboss() {
  url="http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip"
  filename="wildfly-10.1.0.Final.zip"
  name="wildfly-10.1.0.Final"
  packs="/opt/dev/apps/packs/jboss"
  links="/opt/dev/apps/links"
  version="$name"
  output="/tmp/$filename"

  cd "$packs"
  __get_if_unexists "$url" "$filename" && __unzip "$output" "$packs" && __version "$packs" "$version"
  __symlink "$packs/$version" "$links/jboss-$version"
  __symlink "$links/jboss-$version" "$links/jboss"
  cd -
}

__copy_env_files() {
  test ! -e /opt/dev/env && cp -fr env /opt/dev
}

__bind_env_all_to_bashrc() {
  test -z "$(grep 'source /opt/dev/env/all' ~/.bashrc)" && echo 'source /opt/dev/env/all' >> /home/ubuntu/.bashrc
}
