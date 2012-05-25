# NeSI Manifest for MongoDB
# sharding is the secret ingredient in the web-scale sauce!
# http://www.xtranormal.com/watch/6995033/mongo-db-is-web-scale

class mongodb(
  $data_dir  = '/var/lib/mongodb',
  $log_file  = '/var/log/mongodb/mongdb.log',
  $bind_ip   = '127.0.0.1',
  $auth      = false
){
  case $operatingsystem{
    CentOS:{
      class{"mongodb::install":
        data_dir    => $data_dir,
        log_file    => $log_file,
        bind_ip     => $bind_ip,
        auth        => $auth,
      }
    }
    default:{
      warning("MongoDB not configured for ${operatingsystem}")
    }
  }
}