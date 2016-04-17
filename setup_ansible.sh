#!/bin/sh
set -eu
set -x

unsupported_distrib_release() {
  echo 'This script supports only Ubuntu 14.04 and 16.04'
  exit 2
}

check_distrib_release() {
  [ -f /etc/lsb-release ] || unsupported_distrib_release
  . /etc/lsb-release
  [ "$DISTRIB_ID" = "Ubuntu" ] || unsupported_distrib_release
  [ "$DISTRIB_RELEASE" = "14.04" -o "$DISTRIB_RELEASE" = "16.04" ] || unsupported_distrib_release
}


install_ansible_on_trusty() {
  apt-add-repository -y ppa:ansible/ansible
  apt-add-repository -y ppa:hnakamur/python-lxc
  apt-get update
  apt-get install -y ansible python-lxc git
}

install_ansible_on_xenial() {
  apt-get update
  apt-get install -y ansible python-lxc git
}

install_ansible() {
  case $DISTRIB_RELEASE in
  14.04)
    install_ansible_on_trusty
    ;;
  16.04)
    install_ansible_on_xenial
    ;;
  esac
}


check_distrib_release
install_ansible
