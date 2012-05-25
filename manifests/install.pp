# Mongodb installer manifest
# Do NOT call directly, use:
# class{'mongodb':}

class mongodb::install(
  $data_dir,
  $log_dir,
  $bind_ip,
  $auth
){
  
  package{'mongodb-server': ensure => installed}

  user{'mongodb': ensure => present}

  file{$data_dir:
    ensure  => directory,
    owner   => 'mongodb',
    group   => root,
    require => [Package['mongodb-server'],User['mongodb']],
  }

  file{$log_dir:
    ensure  => directory,
    owner   => 'mongodb',
    group   => 'mongodb',
    require => [Package['mongodb-server'],User['mongodb']],
  }

  file{'mongdb_conf':
    ensure  => file,
    owner   => root,
    group   => root,
    path    => '/etc/mongodb.conf',
    content => template('mongodb/mongodb.conf.erb'),
    require => File[$data_dir, $log_dir],
    notify  => Service['mongod'],
  }

  service{"mongod":
    name => "mongod",
    require => [Package["mongodb-server"],File[$data_dir,$log_dir,'mongdb_conf']],
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
  }

}