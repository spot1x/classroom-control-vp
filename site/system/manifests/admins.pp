class system::admins {
  require mysql::server
  
  # Active users: zack, monica, brad, luke
  # Inactive users: ralph
  # Most common parameters: ensure => present, max_queries_per_hour => 1200
  
  $default_max_queries_per_hour = 600
  
  $active_users = {
    'zack' => {
      'max_queries_per_hour' => 1200
    },
    'monica' => {},
    'brad' => {},
    'luke' => {}
  }
  
  $inactive_users = 'ralph'
  
  $active_users.each |String $username, Hash $data| {
    if defined($data['max_queries_per_hour']) {
      $actual_max_queries_per_hour = $data['max_queries_per_hour']
    } else {
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
  
  $inactive_users.each |String $username| {
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
  */

  /*
  user { ['zack', 'monica', 'ralph', 'brad', 'luke']:
    ensure => present,
  }
  */
}
