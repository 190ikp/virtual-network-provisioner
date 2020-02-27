#!/usr/bin/env bash
set -euo pipefail


setup() {

  sudo add-apt-repository universe
  sudo apt update
  sudo debconf-set-selections <<< 'libssl1.1:amd64 libraries/restart-without-asking boolean true'
  sudo apt upgrade --yes

  sudo apt install --yes \
    build-essential \
    linux-headers-"$(uname -r)"
}

eval "$1"