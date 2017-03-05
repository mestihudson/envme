#!/bin/sh
(mkdir -p "/opt/dev/{apps,bin,desktops,scripts,ws}" && mkdir -p "/opt/dev/apps/{links,packs}" && mkdir -p "/opt/dev/apps/packs/{eclipse,jboss,jdk,maven,node,rtc-client,tomcat}")

(ln -s /usr/lib/jvm/java-8-openjdk-amd64 /opt/dev/apps/links/openjdk8 && ln -s /opt/dev/apps/links/openjdk8 /opt/dev/apps/links/jdk8 && ln -s /opt/dev/apps/links/jdk8 /opt/dev/apps/links/jdk)

(cd /opt/dev/apps/packs && wget -qO- http://ftp.unicamp.br/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar xvz && mv /opt/dev/apps/packs/maven/apache-maven-3.3.9 /opt/dev/apps/packs/maven/3.3.9 && ln -s /opt/dev/apps/packs/maven/3.3.9 /opt/apps/links/maven)

(cd /opt/dev/apps/packs/jboss && wget -q http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip -O wildfly-10.1.0.Final.zip && ln -s /opt/dev/apps/packs/jboss/wildfly-10.1.0.Final /opt/dev/apps/links/wildfly-10.1.0.Final && ln -s /opt/dev/apps/links/wildfly-10.1.0.Final /opt/dev/apps/links/jboss && rm -f wildfly-10.1.0.Final.zip)

(cp -fr env /opt/dev && echo "source /opt/dev/env/all" >> /home/ubuntu/.bashrc)
