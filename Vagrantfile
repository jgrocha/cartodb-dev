# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.synced_folder "config/", "/usr/local/etc/", owner: "root", group: "root"
  config.vm.provision :shell, :path => "./setup/deb-deps.sh"
  config.vm.provision :shell, :path => "./setup/fetch-sources.sh"
  config.vm.provision :shell, :path => "./setup/postgis-install.sh"
  config.vm.provision :shell, :path => "./setup/postgis-setup.sh"
  config.vm.provision :shell, :path => "./setup/python-deps.sh"
  config.vm.provision :shell, :path => "./setup/node-deps.sh"
  config.vm.provision :shell, :path => "./setup/ruby-deps.sh"
  config.vm.provision :shell, :path => "./setup/cartodb-setup.sh"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 8181, host: 8181
  # stop tomcat on host
  config.vm.network :forwarded_port, guest: 8080, host: 8080
end
