# List of packages to install
$packages = [ 'wget', 'tmux', 'git', 'postgresql-server', 'postgresql-contrib' ]
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
  exec { "update_centos":
    command => 'yum clean all; yum update -y -q',
    path => '/usr/bin/',
  }

  contain install_packages
  contain install_modules
}

class install_packages {
  notify { 'Installing packages': }
  package { $packages:
    ensure => 'installed',
  }
}

class install_modules {
  notify { 'Installing Puppet modules': }
  exec { 'puppet_modules1':
    command => "puppet module install puppetlabs-stdlib",
    path => '/usr/bin/',
  }

  exec { 'puppet_modules2':
    command => "puppet module install puppetlabs-apt",
    path => '/usr/bin/',
  }

  exec { 'puppet_modules3':
    command => "puppet module install puppetlabs-concat",
    path => '/usr/bin/',
  }

  exec { 'puppet_modules4':
    command => "puppet module install puppetlabs-postgresql",
    path => '/usr/bin/',
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
    groups => 'summer',
    password => '*',
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
