# List of packages to install
$packages = [ 'wget', 'postgresql-server', 'postgresql-contrib', 'tmux', 'git', 'tree', 'emacs-nox', 'nano' ]
$puppet_modules = [ 'puppetlabs-stdlib', 'puppetlabs-apt', 'puppetlabs-concat', 'puppetlabs-postgresql' ]

# Everything assigned to the prepare stage will be applied before the classes
# associated with the main stage
stage { 'prepare':
  before => Stage['main'],
}

# All clasess will be applied before the last stage
stage { 'last': }
Stage['main'] -> Stage['last']

# Prepare stage to install essential packages and puppet modules
class initial_setup {
  notify { 'Updating CentOS': }
  exec { 'update_centos':
    command => 'yum update -y',
    path => '/usr/bin/',
  }

  contain install_packages
}

class install_packages {
  notify { 'Installing packages': }
  package { $packages:
    ensure => 'installed',
  }
}

# Main stage to configure the virtual machine
class create_users {
  notify { 'Creating summer group': }
  group { 'summer':
    ensure => 'present',
  }

  notify { 'Creating summer user': }
  user { 'summer':
    ensure => 'present',
    comment => 'summer user',
    managehome => true,
    groups => ['summer', 'wheel', 'vagrant', 'vboxsf'],
    password => 'summergo',
    shell => '/bin/bash',
  }

}

class {
  'initial_setup':
    stage => prepare;
  'create_users':
    stage => main;
  'golang':
    stage => last;
  'postgresql':
    stage => last;
}
