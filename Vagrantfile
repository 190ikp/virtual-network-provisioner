# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  num_spine = 2
  num_leaf = 2
  num_node_per_leaf = 1

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
        spine.vm.network "private_network", virtualbox__intnet: "intnet#{i}_#{j}", auto_config: false
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
        leaf.vm.network "private_network", virtualbox__intnet: "intnet#{j}_#{i}", auto_config: false
      end
      (1..num_node_per_leaf).each do |k|
        leaf.vm.network "private_network", virtualbox__intnet: "node#{i}_#{k}", auto_config: false
      end
    end
  end

  # server provisioning
  (1..num_leaf).each do |i|
    (1..num_node_per_leaf).each do |j|
      config.vm.define "node-#{i}_#{j}" do |node|
        node.vm.box = "ubuntu/bionic64"
        node.vm.provider "virtualbox" do |vb|
          vb.name = "node-#{i}_#{j}"
          vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
        end

        # configure physical link
        node.vm.network "private_network", virtualbox__intnet: "node#{i}_#{j}", auto_config: false
      end
    end
  end
end
