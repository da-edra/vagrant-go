# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set default locale
ENV["LC_ALL"] = "es_MX.UTF-8"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  # Use CentOS as base distribution
  config.vm.box = "centos/7"

  # Provision VM with Shell to install puppet
  config.vm.provision "shell", inline: <<-SHELL
     echo "Installing Puppet to continue provision"
     yum install epel-release -y -q
     yum install puppet -y -q
     echo "Puppet intalled!"
  SHELL

  # Continue provision with puppet file
  config.vm.provision "puppet" do |puppet|
    puppet.environment_path = "environments"
    puppet.environment = "development"
  end

  config.vm.synced_folder "../summer", "/home/summer/go/src/github.com/conekta/summer",
                          group: "wheel",
                          mount_options: ["dmode=777,fmode=777"]

  config.vm.synced_folder "../conekta-go", "/home/summer/go/src/github.com/conekta/conekta-go",
                          group: "wheel",
                          mount_options: ["dmode=777,fmode=777"]
end

