#!/bin/sh
source ./provision.functions.sh

__mkdirs && __mk_jdk_links && __install_maven && __install_jboss && __copy_env_files &&  __bind_env_all_to_bashrc
