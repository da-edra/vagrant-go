# bin, #pkg, #src
class postgresql {
  exec { 'init_db':
    command => "sudo -u postgres postgresql-setup initdb",
    path => '/usr/bin/',
  }

  exec { 'enable_postgresql':
    command => 'systemctl enable postgresql',
    path => '/usr/bin/',
    require => Exec["init_db"],
  }

  exec { 'start_postgresql':
    command => 'systemctl start postgresql.service',
    path => '/usr/bin/',
    require => Exec["enable_postgresql"],
  }

  exec { 'create_db':
    command => 'sudo -u postgres createdb summer',
    path => '/usr/bin/',
    require => Exec["start_postgresql"],
  }

  exec { 'create_test_db':
    command => 'sudo -u postgres createdb summer_test',
    path => '/usr/bin/',
    require => Exec["start_postgresql"],
  }
}
