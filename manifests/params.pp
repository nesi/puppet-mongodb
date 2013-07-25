class mongodb::params {
  $data_dir   = '/var/lib/mongodb'
  $log_dir    = '/var/log/mongodb'
  case $::osfamily{
    RedHat:{
      $packages_dists = []
      $packages_10gen = ['mongodb-10gen-server']
    }
    Debian:{
      $packages_dists = ['mongodb-server']
      $packages_10gen = ['mogodb-10gen']
    }
    default:{
      fail{"MongoDB not configured for ${::osfamily} on ${::fqdn}":}
    }
  }

}