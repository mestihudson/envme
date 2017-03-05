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

__install_maven() {
  url="http://ftp.unicamp.br/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz"
  filename="apache-maven-3.3.9-bin.tar.gz"
  output="/tmp/$filename"
  pack_dir="/opt/dev/apps/packs/maven"
  link_dir="/opt/dev/apps/links"
  pack_version_dir="3.3.9"

  cd "$pack_dir"
  test ! -e "$output" && wget "$url" -O "$output" && tar xvzf "$output" && md5sum "$output" > "MD5.$filename" && mv "$pack_dir/apache-maven-$pack_version_dir" "$pack_dir/$pack_version_dir" && rm -f apache-maven-3.3.9-bin.tar.gz
  ln -s "$pack_dir/$pack_version_dir" "$link_dir/maven3"
  ln -s "$link_dir/maven3" "$link_dir/maven"
  cd -
}

__install_jboss() {
  url="http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip"
  filename="wildfly-10.1.0.Final.zip"
  output="/tmp/$filename"
  pack_dir="/opt/dev/apps/packs/jboss"
  link_dir="/opt/dev/apps/links"
  pack_version_dir="wildfly-10.1.0.Final"

  cd "$pack_dir"
  test ! -e "$output" && wget "$url" -O "$output" && md5sum "$output" > "MD5.$filename" && unzip "$output" && rm -f "$output"
  ln -s "$pack_dir/$pack_version_dir" "$link_dir/wildfly-10.1.0.Final"
  ln -s "$link_dir/wildfly-10.1.0.Final" "$link_dir/jboss"
  cd -
}

__copy_env_files() {
  test ! -e /opt/dev/env && cp -fr env /opt/dev
}

__bind_env_all_to_bashrc() {
  test -z "$(grep 'source /opt/dev/env/all' ~/.bashrc)" && echo 'source /opt/dev/env/all' >> /home/ubuntu/.bashrc
}
