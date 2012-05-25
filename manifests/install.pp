# Mongodb installer manifest
# Do NOT call directly, use:
# class{'mongodb':}

class mongodb::install(
  $data_dir,
  $log_file,
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

  file{$log_file:
    ensure  => directory,
    owner   => 'mongodb',
    group   => root,
    require => [Package['mongodb-server'],User['mongodb']],
  }

  file{'mongdb_conf':
    ensure  => file,
    owner   => root,
    group   => root,
    path    => '/etc/mongodb.conf',
    content => template('mongodb/mongdb.conf.erb'),
    require => File[$data_dir, $log_file],
    # notify  => Service['mongod'],
  }

}