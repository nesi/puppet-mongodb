# Downloads the Geghis web UI for MongoDB
# Do not call directly.

class mongodb::web::genghis::download(
  $web_root,
  $app_root
){

  exec{'get_genghis':
    cwd       => $web_root,
    user      => root,
    path      => ['/usr/bin'],
    command   => "git clone -b master git://github.com/bobthecow/genghis.git ${app_root}",
    creates   => $app_root,
    require   => Service['mongod'],
  }

}