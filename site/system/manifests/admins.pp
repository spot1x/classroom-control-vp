class system::admins {
  require mysql::server
  
  $default_max_queries_per_hour = 600
  
  $active_users = {
    'zack' => {
      'max_queries_per_hour' => 1200
    },
    'monica' => {},
    'brad' => {},
    'luke' => {}
  }
  
  $inactive_users = [ 'ralph' ]
  
  $active_users.each |String $user, Hash $data| {
    if $data['max_queries_per_hour'] {
      $actual_max_queries_per_hour = $default_max_queries_per_hour
    }
    mysql_user { "${username}@localhost":
      ensure => present,
      max_queries_per_hour => $actual_max_queries_per_hour,
    }
    
    user { $username:
      ensure => present,
    }
  }
  
  $inactive_users.each |String $user| {
    mysql_user { "${username}@localhost":
      ensure => absent,
    }
    
    user { $username:
      ensure => absent,
    }
  }
  
  /*
  mysql_user { 'zack@localhost':
    ensure => present,
    max_queries_per_hour => 1200,
  }
  mysql_user { 'monica@localhost':
    ensure => present,
    max_queries_per_hour => 600,
  }
  mysql_user { 'ralph@localhost':
    ensure => absent,
  }
  mysql_user { 'brad@localhost':
    ensure => present,
    max_queries_per_hour => 600,
  }
  mysql_user { 'luke@localhost':
    ensure => present,
    max_queries_per_hour => 600,
  }

  user { ['zack', 'monica', 'ralph', 'brad', 'luke']:
    ensure => present,
  }
  */
}
