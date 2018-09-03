![README banner](banner.png)
# Vagrant for Go

Vagrant is a tool for managing and configuring virtualised and reproducible development environments.

#### Enforce Consistency

The cost of fixing a bug exponentially increases the closer it gets to production. Vagrant aims to mirror production environments by providing the same operating system, packages, users, and configurations, all while giving developers the flexibility to use their favorite editor, IDE, and browser.

#### About this VM:
This Vagrant setup uses:

+ **Virtual Box** as a VM provider.
+ **Puppet** as provisioner for configruation management.
+ **CentOS 7** as base distribution.

To create a ready to use **Go** development envionment with **PostgreSQL**.

## Installation
#### Prerequisites:

+ [VirtualBox](https://download.virtualbox.org/virtualbox/5.2.18/VirtualBox-5.2.18-124319-OSX.dmg)
+ [Vagrant](https://releases.hashicorp.com/vagrant/2.1.4/vagrant_2.1.4_x86_64.dmg)

After installing both dependencies move to the directory where you cloned this GitHub repository and run:

    vagrant plugin install vagrant-vbguest

#### Usage:
Start the VM:

    vagrant up
Log into the VM:

    vagrant ssh
