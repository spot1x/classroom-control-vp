class system::admins {
  require mysql::server
  
  $admin_users = {
    'zack'    => {max_queries_per_hour => '1200'},
    'monitca' => {max_queries_per_hour => '600'},
    'brad'    => {max_queries_per_hour => '600'},
    'luke'    => {max_queries_per_hour => '600'},
  }
  
  $retired_users = ['ralph']
  
  $admin_users.each|String $user, $params|{
    mysql_user { "${user}@localhost":
      ensure               => present,
      max_queries_per_hour => $params['max_queries_per_hour']
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
