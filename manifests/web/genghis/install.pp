# The genghis installer
# do not use directyl, use:
# class{'mongodb::web::genghis':}

class mongodb::web::genghis::install(
  $web_root
){

  $app_root = "${web_root}/genghis"

  package{'php-pecl-mongo': ensure => installed}

  class{'mongodb::web::genghis::download':
    web_root    => $web_root,
    app_root    => $app_root,
  }

}