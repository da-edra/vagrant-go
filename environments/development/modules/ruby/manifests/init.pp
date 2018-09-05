# Install Rbenv with Ruby and some gems
$gems = [ 'openssl', 'json-jwt' ]
$path = 'export PATH="\$HOME/.rbenv/bin:\$PATH"'
$init = 'eval "\$(rbenv init -)"'

# An ugly command but requiered to install rbenv
class ruby {
  notify { 'Installing Rbenv': }
  exec { 'rbenv_dependencies':
    command => 'yum install git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel -y -q',
    path => '/usr/bin/',
  }

  exec { 'download_script':
    command => "wget -O /usr/local/src/rbenv.sh https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer",
    creates => "/usr/local/src/rbenv.sh",
    path => '/usr/bin/',
    require => Exec["rbenv_dependencies"],
  }

  exec { 'execute_script':
    command => "chmod +x /usr/local/src/rbenv.sh && /usr/local/src/rbenv.sh",
    creates => "/usr/local/src/rbenv.sh",
    path => '/usr/bin/',
    require => Exec["download_script"],
  }

  exec { 'export_path':
    command => "echo $path >> /home/vagrant/.bash_profile",
    unless  => "grep -q /usr/local/go /home/vagrant/.bash_profile ; /usr/bin/test $? -eq 0",
    path => '/usr/bin/',
  }

  exec { 'init_rbenv':
    command => "echo $init >> /home/vagrant/.bash_profile",
    unless  => "grep -q /usr/local/go /home/vagrant/.bash_profile ; /usr/bin/test $? -eq 0",
    path => '/usr/bin/',
  }

  exec { 'install_ruby':
    command => "rbenv global 2.5.1",
    path => '/usr/bin/',
  }
}
