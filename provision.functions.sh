#!/bin/sh
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
  cd /opt/dev/apps/packs/maven
  wget http://ftp.unicamp.br/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar xvz
  mv /opt/dev/apps/packs/maven/apache-maven-3.3.9 /opt/dev/apps/packs/maven/3.3.9
  ln -s /opt/dev/apps/packs/maven/3.3.9 /opt/apps/links/maven
  cd -
}

__install_jboss() {
  cd /opt/dev/apps/packs/jboss
  wget http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip -O wildfly-10.1.0.Final.zip
  ln -s /opt/dev/apps/packs/jboss/wildfly-10.1.0.Final /opt/dev/apps/links/wildfly-10.1.0.Final
  ln -s /opt/dev/apps/links/wildfly-10.1.0.Final /opt/dev/apps/links/jboss
  rm -f wildfly-10.1.0.Final.zip
  cd -
}

__copy_env_files() {
  test ! -e /opt/dev/env && cp -fr env /opt/dev
}

__bind_env_all_to_bashrc() {
  test -z "$(grep 'source /opt/dev/env/all' ~/.bashrc)" && echo 'source /opt/dev/env/all' >> /home/ubuntu/.bashrc
}
