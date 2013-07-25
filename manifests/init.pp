# Class: mongodb
#
# This module manages mongodb
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

# This file is part of the mongodb Puppet module.
#
#     The mongodb Puppet module is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     The mongodb Puppet module is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with the mongodb Puppet module.  If not, see <http://www.gnu.org/licenses/>.

# [Remember: No empty lines between comments and class definition]
# NeSI Manifest for MongoDB
# sharding is the secret ingredient in the web-scale sauce!
# http://www.xtranormal.com/watch/6995033/mongo-db-is-web-scale
class mongodb(
  $data_dir    = $mongodb::params::data_dir,
  $log_dir     = $mongodb::params::data_dir,
  $use_10gen   = true,
  $bind_ip     = undef,
  $auth        = undef,
  $journaling  = undef
) inherits mongodb::params {

  validate_bool($use_10gen)
  
  if $use_10gen {

    $packages = $mongodb::params::packages_10gen

    package{$mongdb::params::dis_packages: 
      ensure => absent,
    }

    case $::osfamily {
      RedHat:{
        yumrepo { "10gen":
          baseurl => "http://downloads-distro.mongodb.org/repo/redhat/os/${::hardwaremodel}",
          descr => "The 10gen repository for installing MongoDB",
          enabled => "1",
          gpgcheck => "0",
        }
      }
      Debian:{

        $os_repo = $::operatingsystem ? {
          'Ubuntu' => 'ubuntu-upstart',
          'Debian' => 'debian-sysvinit',
        }

        apt::source { 'mongodb_10gen':
          location          => "http://downloads-distro.mongodb.org/repo/${os_repo}",
          release           => 'dist',
          repos             => '10gen',
          key               => '7F0CEB10',
          key_server        => 'keyserver.ubuntu.com',
        }
        
      }
      default:{
        fail{"MongoDB not configured for ${::osfamily} on ${::fqdn}":}
      }
    }
  } else {
    $packages = $mongodb::params::packages_dists
    package{$mongodb::params::packages_10gen:
      ensure => absent,
    }
    if $::osfamily == RedHat {
      fail{'MongoDB must be installed from the 10gen repository, set `use_10gen => true` parameter.':}
    }
  }
}
