class system::admins {
  require mysql::server
  
# You can either use this resource default, or declare each parameter
# directly in the $admins hash
#   Mysql_user {
#     max_queries_per_hour => '600',
#   }

  $retired = [ 'ralph' ]
  $admins = {
    'brad'    => { max_queries_per_hour => '600' },
    'monica'  => { max_queries_per_hour => '600' },
    'luke'    => { max_queries_per_hour => '600' },
    'zack'    => { max_queries_per_hour => '1200' },
    }

  $admins.each |$user, $params| {
    mysql_user { "${user}@localhost":
      ensure => present,
      max_queries_per_hour => $params['max_queries_per_hour'],
    }
  
    user { $user:
      ensure => present,
      managehome => true,
    }
  }

  $retired.each |$user| {
    mysql_user { "${user}@localhost":
      ensure => absent,
    }

    user { $user:
      ensure => absent,
    }
  }
}
include system::admins
