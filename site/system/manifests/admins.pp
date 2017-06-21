class system::admins {
  require mysql::server
  
  default_max_queries_per_hour = '600'
  
  $admin_users = {
    'zack'    => {max_queries_per_hour => '1200'},
    'monitca' => {},
    'brad'    => {},
    'luke'    => {},
  }
  
  $retired_users = ['ralph']
  
  $admin_users.each|String $user, Hash $data|{
    mysql_user { "${user}@localhost":
      ensure               => present,
      max_queries_per_hour => pick($data['max_queries_per_hour'], $default_max_queries_per_hour)
    }
    user { $user:
      ensure     => present,
      managehome => true,
    }
  }
  
  $retired_users.each|String $user|{
    mysql_user { "${user}@localhost":
      ensure => absent,
    }
    user { $user:
      ensure     => present,
    }
  }
}
