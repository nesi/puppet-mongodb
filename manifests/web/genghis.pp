# Installs a web interface for Mongodb
# http://genghisapp.com/

class mongodb::web::genghis(
  $web_root = '/var/www/html'
){
  case $operatingsystem {
    CentOS:{
      class {'mongodb::web::genghis::install':
        web_root => $web_root,
      }
    }
    default:{
      warning("The Genghis web UI for mongodb is not configured for ${operatingsystem} on ${fqdn}")
    }
  }
  
}