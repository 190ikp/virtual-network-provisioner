# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end

  # spine switch provisioning
  (1..2).each do |i|
    config.vm.define "spine-#{i}" do |spine|
      spine.vm.box = "CumulusCommunity/cumulus-vx"
      spine.vm.provider "virtualbox" do |vb|
        vb.name = "spine-#{i}"
        vb.customize ["modifyvm", :id, "--ostype", "Linux_64"]
      end

      # configure physical NIC
      (1..4).each do |j|
        spine.vm.network "private_network", virtualbox__intnet: "swp#{j}", auto_config: false
      end
    end
  end

  # leaf switch provisioning
  (1..3).each do |i|
    config.vm.define "leaf-#{i}" do |leaf|
      leaf.vm.box = "CumulusCommunity/cumulus-vx"
      leaf.vm.provider "virtualbox" do |vb|
        vb.name = "leaf-#{i}"
        vb.customize ["modifyvm", :id, "--ostype", "Linux_64"]
      end

      # configure physical NIC
      (1..4).each do |j|
        leaf.vm.network "private_network", virtualbox__intnet: "swp#{j}", auto_config: false
      end
    end
  end

  # server provisioning
  (1..3).each do |i|
    config.vm.define "server-#{i}" do |node|
      node.vm.box = "ubuntu/bionic64"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "node-#{i}"
        vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
      end

      # configure physical NIC
      node.vm.network "private_network", virtualbox__intnet: "eth0", auto_config: false
      node.vm.network "private_network", virtualbox__intnet: "eth1", auto_config: false

      node.vm.provision "shell", privileged: false, inline: <<-SHELL
        sudo add-apt-repository universe
        sudo apt update
        sudo debconf-set-selections <<< 'libssl1.1:amd64 libraries/restart-without-asking boolean true'
        sudo apt upgrade --yes
      SHELL
    end
  end
end
