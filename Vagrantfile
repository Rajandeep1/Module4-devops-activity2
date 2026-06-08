# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "rajandeep"

  config.vm.network "private_network", ip: "192.168.56.67"
  config.vm.network "public_network", bridge: "MediaTek Wi-Fi 7 MT7925 160MHz PCIe Adapter"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end
end
