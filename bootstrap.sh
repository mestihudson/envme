#!/bin/sh
# apt-get update
apt-get install -y git-core unzip openjdk-8-jdk

chown -R ubuntu:ubuntu /opt
su - ubuntu -c "cd /tmp && git clone https://github.com/mestihudson/envme.git"
# su - ubuntu -c "cd /tmp && git clone https://github.com/mestihudson/envme.git && cd envme && ./provision.sh"
