#!/usr/bin/env bash

set -euo pipefail

setup_network() {
  envsubst \$NODE_IP\$GATEWAY_IP < conf/netplan/50-cloud-init.yaml |
    sudo dd of=/etc/netplan/50-cloud-init.yaml

  sudo netplan apply
}

eval "$1"