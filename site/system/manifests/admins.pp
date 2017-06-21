class system::admins {
  require mysql::server
  
  $default_max_queries_per_hour = 600
  
  $inactive_users = ['ralph']
  
  $active_users = {
    'zack' => {
      'active' => true, 
      'max_queries_per_hour' => 1200
      },
    }
    
  $active_users.each | String $active_user, Hash $data| {
    if defined($data['max_queries_per_hour']) {
      $actual_max_queries_per_hour = $data['max_queries_per_hour']
    } else {
    
    mysql_user { "${admin}@localhost":
      ensure               => present,
      max_queries_per_hour => $actual_max_queries_per_hour,
    }
  }
  
  user { $sername:
    ensure => present,
    }
  
  $inactive_users.each | String $inactive_user| {
    mysql_user { "${inactive_user}@localhost":
      ensure               => absent,
    }
  }
  user { $sername:
    ensure => present,
    }
}
