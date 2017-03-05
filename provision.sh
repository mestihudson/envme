#!/bin/sh
mkdir -p /opt/dev/{apps,bin,desktops,scripts,ws}
mkdir -p /opt/dev/apps/{links,packs}
mkdir -p /opt/dev/apps/packs/{eclipse,jboss,jdk,maven,node,rtc-client,tomcat}

(apt-get install -y openjdk-8-jdk && ln -s /usr/lib/jvm/java-8-openjdk-amd64 /opt/dev/apps/links/openjdk8 && ln -s /opt/dev/apps/links/openjdk8 /opt/dev/apps/links/jdk8 &&  && ln -s /opt/dev/apps/links/jdk8 /opt/dev/apps/links/jdk)

(cd /opt/dev/apps/packs && wget -qO- http://ftp.unicamp.br/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar xvz && mv /opt/dev/apps/packs/maven/apache-maven-3.3.9 /opt/dev/apps/packs/maven/3.3.9 && ln -s /opt/dev/apps/packs/maven/3.3.9 /opt/apps/links/maven)

cp -fr env /opt/dev
echo "source /opt/dev/env/all" >> /home/ubuntu/.bashrc
chown -R ubuntu:ubuntu /opt
