#!/bin/sh
# apt-get update
apt-get install -y git-core unzip openjdk-8-jdk

chown -R ubuntu:ubuntu /opt
su - ubuntu -c "cd /tmp && git clone https://github.com/mestihudson/envme.git && cd envme && ./provision.sh"
cp -f /tmp//envme/ssh_config /etc/ssh/ssh_config 
