# Manifest to install Go

class golang ( $version = '1.10.4' ) {
  exec { 'download_golang':
    command => "wget -O /usr/local/src/go$version.tar.gz https://dl.google.com/go/go$version.linux-amd64.tar.gz",
    creates => "/usr/local/src/go$version.tar.gz",
    path => '/usr/bin/',
  }

  exec { 'unarchive_golang_tools':
    command => "tar -C /usr/local -xzf /usr/local/src/go$version.tar.gz",
    path => '/usr/bin/',
    require => Exec["download_golang"],
  }

  exec { 'setup_path':
    command => "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /home/vagrant/.bash_profile",
    unless  => "grep -q /usr/local/go /home/vagrant/.bash_profile ; /usr/bin/test $? -eq 0",
    path => '/usr/bin/',
  }

  exec { 'setup_workspace':
    command => "echo 'export GOPATH=/vagrant' >> /home/vagrant/.bash_profile",
    unless  => "grep -q GOPATH /home/vagrant/.bash_profile ; /usr/bin/test $? -eq 0",
    path => '/usr/bin/'
  }
  contain go_directories
}

class go_directories {
  $go_directories = [ '/home/vagrant/go', '/home/vagrant/go/bin', '/home/vagrant/go/pkg', '/home/vagrant/go/src' ]

  file { $go_directories:
    ensure => 'directory',
    owner => 'vagrant',
    group => 'vagrant',
    mode => '0755',
  }

  exec { 'vagrant_owner':
    command => "chown -R vagrant /home/vagrant/go/",
    path => '/usr/bin/',
  }
}
