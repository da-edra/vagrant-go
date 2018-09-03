# bin, #pkg, #src
class postgresql ( $version = '1.10.4' ) {
  exec { 'init_db':
    command => "postgresql-setup initdb",
    path => '/usr/bin/',
  }

  exec { 'start_postgresql':
    command => 'pg_ctl -D /usr/local/var/postgres start',
    path => '/usr/bin/',
    require => Exec["init_db"],
  }

  exec { 'create_db':
    command => 'createdb summer',
    path => '/usr/bin/',
    require => Exec["start_postgresql"],
  }

  exec { 'create_test_db':
    command => 'createdb summer_test',
    path => '/usr/bin/',
    require => Exec["start_postgresql"],
  }

  exec { 'enable_postgresql':
    command => 'systemctl enable postgresql',
    path => '/usr/bin/',
    require => Exec["init_db"],
  }
}
