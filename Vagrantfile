# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  num_spine = 2
  num_leaf = 2
  num_node = 2

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box 
  end

  # spine switch provisioning
  (1..num_spine).each do |i|
    config.vm.define "spine-#{i}" do |spine|
      spine.vm.box = "CumulusCommunity/cumulus-vx"
      spine.vm.provider "virtualbox" do |vb|
        vb.name = "spine-#{i}"
        vb.customize ["modifyvm", :id, "--ostype", "Linux_64"]
      end

      # configure physical link
      (1..num_leaf).each do |j|
        spine.vm.network "private_network", virtualbox__intnet: "intnet#{i}#{j}", auto_config: false
      end

    end
  end

  # leaf switch provisioning
  (1..num_leaf).each do |i|
    config.vm.define "leaf-#{i}" do |leaf|
      leaf.vm.box = "CumulusCommunity/cumulus-vx"
      leaf.vm.provider "virtualbox" do |vb|
        vb.name = "leaf-#{i}"
        vb.customize ["modifyvm", :id, "--ostype", "Linux_64"]
      end

      # configure physical link
      (1..num_spine).each do |j|
        leaf.vm.network "private_network", virtualbox__intnet: "intnet#{j}#{i}", auto_config: false
      end
      leaf.vm.network "private_network", virtualbox__intnet: "node#{i}", auto_config: false

    end
  end

  # server provisioning
  (1..num_node).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.box = "ubuntu/bionic64"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "node-#{i}"
        vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
      end

      # configure physical link
      node.vm.network "private_network", virtualbox__intnet: "node#{i}", auto_config: false

      node.vm.provision "shell", privileged: false, inline: <<-SHELL
        sudo add-apt-repository universe
        sudo apt update
        sudo debconf-set-selections <<< 'libssl1.1:amd64 libraries/restart-without-asking boolean true'
        sudo apt upgrade --yes
      SHELL
    end
  end
end
