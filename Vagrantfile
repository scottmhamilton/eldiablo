# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/xenial64"
  config.vm.provision :shell, :path => "bootstrap.sh"
end
