# bin, #pkg, #src
class golang ( $version = '1.10.4' ) {
  exec { 'download_golang':
    command => "wget -O /usr/local/src/go$version.tar.gz https://dl.google.com/go/go1.10.4.linux-amd64.tar.gz",
    creates => "/usr/local/src/go$version.tar.gz",
    path => '/usr/bin/',
  }

  exec { 'unarchive_golang_tools':
    command => "tar -C /usr/local -xzf /usr/local/src/go$version.tar.gz",
    path => '/usr/bin/',
    require => Exec["download_golang"],
  }

  exec { 'setup_path':
    # command => "echo 'export PATH=/vagrant/bin:/usr/local/go/bin:\$PATH' >> /home/vagrant/.profile",
    command => "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /home/vagrant/.bash_profile",
    unless  => "grep -q /usr/local/go /home/vagrant/.bash_profile ; /usr/bin/test $? -eq 0",
    path => '/usr/bin/',
  }

  exec { 'setup_workspace':
    command => "/bin/echo 'export GOPATH=/vagrant' >> /home/vagrant/.bash_profile",
    unless  => "/bin/grep -q GOPATH /home/vagrant/.profile ; /usr/bin/test $? -eq 0",
  }
  contain go_directories
}

class go_directories {
  $go_directories = [ '/home/summer/go', '/home/summer/go/bin', '/home/summer/go/pkg', '/home/summer/go/src' ]

  file { $go_directories:
    ensure => 'directory',
    owner => 'summer',
    group => 'summer',
    mode => '0750',
  }
}
