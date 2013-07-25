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
  $data_dir   = '/var/lib/mongodb',
  $log_dir    = '/var/log/mongodb',
  $bind_ip    = false,
  $auth       = false,
  $journaling = false
){
  case $operatingsystem{
    CentOS:{
      class{"mongodb::install":
        data_dir    => $data_dir,
        log_dir     => $log_dir,
        bind_ip     => $bind_ip,
        auth        => $auth,
        journaling  => $journaling,
      }
    }
    default:{
      warning("MongoDB not configured for ${operatingsystem}")
    }
  }
}
